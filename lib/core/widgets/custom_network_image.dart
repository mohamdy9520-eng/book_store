import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  const CustomNetworkImage({super.key, required this.imageUrl,
    this.height= 175.38, this.width= 140.9,});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl:imageUrl,
      height: height,
      width: width,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => Skeletonizer(
        enabled: true,
        child: Container(
          width: width,
          height: height,
        ),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
