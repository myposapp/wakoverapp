import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wakover/common/constants/config.dart';
import 'package:wakover/theme/app_theme.dart';

/// A rounded thumbnail for CDN image paths returned by the API.
class HubImage extends StatelessWidget {
  const HubImage({
    super.key,
    required this.path,
    this.size = 48,
    this.height,
    this.radius = 12,
    this.fallbackIcon = Icons.shopping_bag_outlined,
  });

  final String? path;
  final double size;

  /// Defaults to [size] for a square thumbnail.
  final double? height;
  final double radius;
  final IconData fallbackIcon;

  @override
  Widget build(BuildContext context) {
    final path = this.path;
    final height = this.height ?? size;
    final fallback = Container(
      width: size,
      height: height,
      color: hubTint(context),
      child: Icon(
        fallbackIcon,
        color: AppTheme.primaryBlue,
        size: (size < height ? size : height) * 0.45,
      ),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: path == null || path.isEmpty
          ? fallback
          : CachedNetworkImage(
              imageUrl: path.startsWith('http')
                  ? path
                  : '${AppConfig.cdnBaseUrl}$path',
              width: size,
              height: height,
              fit: BoxFit.cover,
              placeholder: (_, _) => fallback,
              errorWidget: (_, _, _) => fallback,
            ),
    );
  }
}

/// The soft blue tint used for icon wells and chips across the app.
Color hubTint(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark
    ? AppTheme.accentBlue.withValues(alpha: 0.14)
    : const Color(0xFFEFF4FF);

/// The hairline border the app's cards use.
Color hubBorder(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark
    ? Colors.white.withValues(alpha: 0.08)
    : Colors.black.withValues(alpha: 0.06);

Color hubMutedText(BuildContext context) =>
    Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6);
