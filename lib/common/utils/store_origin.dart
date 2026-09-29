/// Turns a typed or scanned store address into the origin the API expects,
/// e.g. "shop.example.com/product/1" becomes "https://shop.example.com".
/// Returns null when the input isn't a usable web address.
String? normalizeStoreOrigin(String input) {
  var value = input.trim();
  if (value.isEmpty) return null;
  if (!value.contains('://')) value = 'https://$value';

  final uri = Uri.tryParse(value);
  if (uri == null || uri.host.isEmpty || !uri.host.contains('.')) return null;
  if (uri.scheme != 'http' && uri.scheme != 'https') return null;

  return uri.hasPort
      ? '${uri.scheme}://${uri.host}:${uri.port}'
      : '${uri.scheme}://${uri.host}';
}
