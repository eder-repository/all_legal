import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ALCachedImage extends StatelessWidget {
  const ALCachedImage({
    required this.url,
    super.key,
    this.center = true,
    this.builder,
    this.errorHeight,
    this.imageError,
    this.color,
    this.height,
    this.width,
    this.fit,
    this.loaderWidget,
    this.borderRadius,
    this.circular = false,
  });

  final String url;
  final double? errorHeight;
  final bool center;
  final Widget Function(BuildContext, ImageProvider<Object>)? builder;
  final Widget? imageError;
  final Widget? loaderWidget;
  final Color? color;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final double? borderRadius;
  final bool circular;

  @override
  Widget build(BuildContext context) {
    final loader = SizedBox.square(
      dimension: width ?? 24,
      child: const CircularProgressIndicator(strokeWidth: 1.5),
    );

    final calculatedBorderRadius = circular
        ? BorderRadius.circular((width ?? height ?? 0) / 2)
        : BorderRadius.circular(borderRadius ?? 0);

    return ClipRRect(
      borderRadius: calculatedBorderRadius,
      child: CachedNetworkImage(
        fit: fit,
        height: height,
        width: width,
        color: color,
        imageUrl: url,
        placeholder: (_, __) {
          return loaderWidget ?? (center ? Center(child: loader) : loader);
        },
        imageBuilder: builder,
        cacheKey: url,
        errorWidget: (_, __, Object? ___) =>
            imageError ?? const Icon(Icons.error),
      ),
    );
  }
}
