/// Normalizes a Nigerian phone number to E.164 (+234XXXXXXXXXX), accepting
/// "0803…", "803…", "234803…" and "+234803…". Returns null if it isn't a
/// valid 10-digit local number.
String? toNigerianE164(String input) {
  var digits = input.replaceAll(RegExp(r'[^0-9]'), '');
  if (digits.startsWith('234')) digits = digits.substring(3);
  if (digits.startsWith('0')) digits = digits.substring(1);
  return digits.length == 10 ? '+234$digits' : null;
}
