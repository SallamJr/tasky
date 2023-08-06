import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/app_colors.dart';
import '../utils/constants.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    super.key,
    required this.url,
    this.hasBorder = false,
    this.width = 100,
    this.height = 100,
    this.borderRadius,
    this.fit,
    this.borderColor,
  });

  final String url;
  final bool hasBorder;
  final double? width;
  final double? height;
  final double? borderRadius;
  final BoxFit? fit;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: hasBorder
          ? BoxDecoration(
              border: Border.all(
                color: borderColor ?? AppColors.primary,
              ),
              borderRadius: BorderRadius.circular(
                borderRadius ?? Constants.borderRadius,
              ),
            )
          : null,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          borderRadius ?? Constants.borderRadius,
        ),
        child: CachedNetworkImage(
          width: width,
          height: height,
          imageUrl: url,
          fit: fit ?? BoxFit.cover,
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: AppColors.grey,
            highlightColor: AppColors.primary,
            child: Container(
              width: width,
              height: height,
              color: AppColors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
