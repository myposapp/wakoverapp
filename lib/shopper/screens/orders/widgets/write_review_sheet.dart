import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wakover/common/network/provider/network_provider.dart';
import 'package:wakover/shopper/widgets/hub/hub_sheet.dart';
import 'package:wakover/shopper/widgets/hub/hub_states.dart';

typedef ReviewResult = ({dynamic review});

/// Returns the posted review, or null if the sheet was dismissed.
Future<ReviewResult?> showWriteReviewSheet(
  BuildContext context, {
  required String productId,
  required String productName,
}) {
  return showHubSheet<ReviewResult>(
    context,
    title: 'Write a Review',
    child: _WriteReviewForm(productId: productId, productName: productName),
  );
}

class _WriteReviewForm extends StatefulWidget {
  const _WriteReviewForm({required this.productId, required this.productName});

  final String productId;
  final String productName;

  @override
  State<_WriteReviewForm> createState() => _WriteReviewFormState();
}

class _WriteReviewFormState extends State<_WriteReviewForm> {
  final _commentController = TextEditingController();
  int _rating = 5;
  bool _isSubmitting = false;

  static const _ratingLabels = [
    'Poor',
    'Fair',
    'Good',
    'Very good',
    'Excellent',
  ];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _isSubmitting = true);
    try {
      final repo = context.read<NetworkProvider>().shopperNetworkRepo;
      final response = await repo.postProductReview(
        widget.productId,
        rating: _rating,
        comment: _commentController.text.trim(),
      );
      if (!mounted) return;

      if (response.success == true) {
        showHubSnack(context, 'Review posted successfully.');
        Navigator.of(context).pop<ReviewResult>((review: response.data));
      } else {
        showHubSnack(context, response.message ?? 'Failed to post review.');
      }
    } catch (e) {
      if (mounted) showHubSnack(context, e.toString());
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'How was ${widget.productName}?',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var star = 1; star <= 5; star++)
              IconButton(
                onPressed: () => setState(() => _rating = star),
                iconSize: 36,
                icon: Icon(
                  star <= _rating
                      ? Icons.star_rounded
                      : Icons.star_outline_rounded,
                  color: Colors.amber,
                ),
              ),
          ],
        ),
        Text(
          _ratingLabels[_rating - 1],
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _commentController,
          maxLines: 4,
          maxLength: 500,
          decoration: InputDecoration(
            hintText: 'Tell others what you liked or didn\'t (optional)',
            hintStyle: const TextStyle(fontSize: 13),
            filled: true,
            fillColor: Theme.of(context).cardColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 12),
        HubPrimaryButton(
          label: 'Post Review',
          icon: Icons.send_rounded,
          expand: true,
          isBusy: _isSubmitting,
          onPressed: _submit,
        ),
      ],
    );
  }
}
