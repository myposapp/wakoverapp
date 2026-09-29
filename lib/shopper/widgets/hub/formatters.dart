import 'package:intl/intl.dart';

final _nairaFormat = NumberFormat('#,##0.##');

String formatNaira(num? amount) => '₦${_nairaFormat.format(amount ?? 0)}';

/// Formats an API timestamp in local time, e.g. "12 Sep 2026, 4:05 PM".
/// Returns the raw value if it can't be parsed.
String formatDateTime(String? value, {String pattern = 'dd MMM yyyy, h:mm a'}) {
  if (value == null || value.isEmpty) return '';
  final parsed = DateTime.tryParse(value);
  if (parsed == null) return value;
  return DateFormat(pattern).format(parsed.toLocal());
}

String formatDate(String? value) =>
    formatDateTime(value, pattern: 'dd MMM yyyy');

/// Sums a fee map such as {"transaction_fee": 200}; anything else counts as 0.
num sumFees(dynamic fees) {
  if (fees is! Map) return 0;
  return fees.values.whereType<num>().fold<num>(0, (sum, fee) => sum + fee);
}

/// "transaction_fee" -> "Transaction fee".
String humanizeKey(String key) {
  final words = key.replaceAll('_', ' ').trim();
  if (words.isEmpty) return words;
  return words[0].toUpperCase() + words.substring(1);
}
