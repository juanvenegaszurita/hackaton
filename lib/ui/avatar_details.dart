import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AvatarDetails extends StatelessWidget {
  AvatarDetails({
    required this.urlImage,
    this.details = "",
    this.onTap,
    this.width = 100.0,
    this.height = 100.0,
    this.radius = 50.0,
  });
  final String urlImage;
  final String details;
  final void Function()? onTap;
  final double width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    String _imageLogo = (Get.isDarkMode)
        ? 'assets/images/defaultDark.png'
        : 'assets/images/default.png';
    return Container(
      alignment: Alignment.center,
      width: width + 20,
      height: height + (details != "" ? 40 : 20),
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(radius),
            onTap: onTap,
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    (urlImage == "") ? _imageLogo : urlImage,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          if (details != "") Text(details),
        ],
      ),
    );
  }
}
