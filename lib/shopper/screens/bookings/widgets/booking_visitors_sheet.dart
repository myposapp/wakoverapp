import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wakover/common/network/provider/network_provider.dart';
import 'package:wakover/shopper/models/booking_model.dart';
import 'package:wakover/shopper/widgets/hub/formatters.dart';
import 'package:wakover/shopper/widgets/hub/hub_image.dart';
import 'package:wakover/shopper/widgets/hub/hub_sheet.dart';
import 'package:wakover/shopper/widgets/hub/hub_states.dart';
import 'package:wakover/theme/app_theme.dart';

Future<void> showBookingVisitorsSheet(
  BuildContext context, {
  required Booking booking,
  required ValueChanged<List<BookingVisitor>> onChanged,
}) {
  return showHubSheet(
    context,
    title: 'Visitors',
    child: _VisitorsPanel(booking: booking, onChanged: onChanged),
  );
}

class _VisitorsPanel extends StatefulWidget {
  const _VisitorsPanel({required this.booking, required this.onChanged});

  final Booking booking;
  final ValueChanged<List<BookingVisitor>> onChanged;

  @override
  State<_VisitorsPanel> createState() => _VisitorsPanelState();
}

class _VisitorsPanelState extends State<_VisitorsPanel> {
  late List<BookingVisitor> _visitors = [...?widget.booking.visitors];
  String? _removingId;
  bool _isAdding = false;

  void _setVisitors(List<BookingVisitor> visitors) {
    setState(() => _visitors = visitors);
    widget.onChanged(visitors);
  }

  Future<void> _remove(BookingVisitor visitor) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Remove visitor?'),
        content: Text('${visitor.name ?? 'This visitor'} will lose access.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.redAccent),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    setState(() => _removingId = visitor.id);
    try {
      final repo = context.read<NetworkProvider>().shopperNetworkRepo;
      final response = await repo.removeBookingVisitor(
        widget.booking.id ?? '',
        visitor.id ?? '',
      );
      if (!mounted) return;
      if (response.success == true) {
        _setVisitors(_visitors.where((v) => v.id != visitor.id).toList());
      } else {
        showHubSnack(context, response.message ?? 'Failed to remove visitor.');
      }
    } catch (e) {
      if (mounted) showHubSnack(context, e.toString());
    } finally {
      if (mounted) setState(() => _removingId = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isAdding) {
      return _AddVisitorForm(
        bookingId: widget.booking.id ?? '',
        onCancel: () => setState(() => _isAdding = false),
        onAdded: (visitor) {
          _setVisitors([visitor, ..._visitors]);
          setState(() => _isAdding = false);
        },
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Visitors get their own access code to present on arrival.',
          style: TextStyle(fontSize: 12, color: hubMutedText(context)),
        ),
        const SizedBox(height: 16),
        if (_visitors.isEmpty)
          const HubMessage(
            icon: Icons.group_outlined,
            title: 'No visitors yet',
            message: 'Add the people who\'ll be joining you.',
          )
        else
          for (final visitor in _visitors)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _VisitorTile(
                visitor: visitor,
                isRemoving: _removingId == visitor.id,
                onRemove: () => _remove(visitor),
              ),
            ),
        const SizedBox(height: 8),
        HubPrimaryButton(
          label: 'Add Visitor',
          icon: Icons.person_add_alt_1_rounded,
          expand: true,
          onPressed: () => setState(() => _isAdding = true),
        ),
      ],
    );
  }
}

class _VisitorTile extends StatelessWidget {
  const _VisitorTile({
    required this.visitor,
    required this.isRemoving,
    required this.onRemove,
  });

  final BookingVisitor visitor;
  final bool isRemoving;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final code = visitor.code;
    final name = visitor.name ?? 'Visitor';

    return HubCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: hubTint(context),
            child: Text(
              name.isNotEmpty ? name[0].toUpperCase() : '?',
              style: const TextStyle(
                color: AppTheme.primaryBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                for (final line in [
                  visitor.phone,
                  visitor.email,
                  formatDateTime(visitor.dateTime),
                ])
                  if (line != null && line.isNotEmpty)
                    Text(
                      line,
                      style: TextStyle(
                        fontSize: 11,
                        color: hubMutedText(context),
                      ),
                    ),
                if (code != null) ...[
                  const SizedBox(height: 6),
                  InkWell(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: code));
                      showHubSnack(context, 'Access code copied');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: hubTint(context),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        code,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: AppTheme.primaryBlue,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          isRemoving
              ? const Padding(
                  padding: EdgeInsets.all(8),
                  child: SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
              : IconButton(
                  tooltip: 'Remove visitor',
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.redAccent,
                  ),
                  onPressed: onRemove,
                ),
        ],
      ),
    );
  }
}

class _AddVisitorForm extends StatefulWidget {
  const _AddVisitorForm({
    required this.bookingId,
    required this.onCancel,
    required this.onAdded,
  });

  final String bookingId;
  final VoidCallback onCancel;
  final ValueChanged<BookingVisitor> onAdded;

  @override
  State<_AddVisitorForm> createState() => _AddVisitorFormState();
}

class _AddVisitorFormState extends State<_AddVisitorForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _dateTime;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDateTime() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: _dateTime ?? now,
      firstDate: now.subtract(const Duration(days: 1)),
      lastDate: now.add(const Duration(days: 365)),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_dateTime ?? now),
    );
    if (time == null) return;
    setState(() {
      _dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  /// Converts local input like 0803... or 803... to +234803...
  static String? _formatPhone(String input) {
    var digits = input.replaceAll(RegExp(r'[^0-9+]'), '');
    if (digits.startsWith('+')) return digits.length >= 12 ? digits : null;
    if (digits.startsWith('234')) digits = digits.substring(3);
    if (digits.startsWith('0')) digits = digits.substring(1);
    return digits.length == 10 ? '+234$digits' : null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_dateTime == null) {
      showHubSnack(context, 'Please pick the visit date and time');
      return;
    }

    setState(() => _isSubmitting = true);
    try {
      final repo = context.read<NetworkProvider>().shopperNetworkRepo;
      final email = _emailController.text.trim();
      final description = _descriptionController.text.trim();
      final response = await repo.addBookingVisitor(
        widget.bookingId,
        name: _nameController.text.trim(),
        phone: _formatPhone(_phoneController.text)!,
        dateTime: _dateTime!.toUtc().toIso8601String(),
        email: email.isEmpty ? null : email,
        description: description.isEmpty ? null : description,
      );
      if (!mounted) return;

      if (response.success == true && response.data != null) {
        widget.onAdded(response.data!);
      } else {
        showHubSnack(context, response.message ?? 'Failed to add visitor.');
      }
    } catch (e) {
      if (mounted) showHubSnack(context, e.toString());
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  InputDecoration _decoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, size: 18),
      filled: true,
      fillColor: Theme.of(context).cardColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: hubBorder(context)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: hubBorder(context)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateTime = _dateTime;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: widget.onCancel,
                icon: const Icon(Icons.arrow_back_rounded),
              ),
              const Text(
                'New visitor',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: _pickDateTime,
            borderRadius: BorderRadius.circular(14),
            child: InputDecorator(
              decoration: _decoration('Date & Time *', Icons.event_rounded),
              child: Text(
                dateTime == null
                    ? 'Choose when they\'ll arrive'
                    : formatDateTime(dateTime.toIso8601String()),
                style: TextStyle(
                  fontSize: 14,
                  color: dateTime == null ? hubMutedText(context) : null,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _nameController,
            textCapitalization: TextCapitalization.words,
            maxLength: 60,
            decoration: _decoration('Name *', Icons.person_outline_rounded),
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Name is required' : null,
          ),
          const SizedBox(height: 4),
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: _decoration('Phone *', Icons.phone_outlined),
            validator: (v) => _formatPhone(v ?? '') == null
                ? 'Enter a valid phone number'
                : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: _decoration('Email', Icons.alternate_email_rounded),
            validator: (v) {
              final value = v?.trim() ?? '';
              if (value.isEmpty) return null;
              return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value)
                  ? null
                  : 'Invalid email';
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _descriptionController,
            maxLines: 3,
            maxLength: 500,
            decoration: _decoration('Description', Icons.notes_rounded),
          ),
          const SizedBox(height: 8),
          HubPrimaryButton(
            label: 'Add Visitor',
            expand: true,
            isBusy: _isSubmitting,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}
