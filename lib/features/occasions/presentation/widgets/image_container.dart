
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../styles/colors/color_manager.dart';

class ImageContainer extends StatelessWidget {
  final String imageUrl;
  const ImageContainer({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius:  BorderRadius.circular(15.0),
        border: Border.all(color: ColorManager.primaryBlue),
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: MediaQuery.sizeOf(context).height * 0.3,
        width: MediaQuery.sizeOf(context).width*0.3,
        fit: BoxFit.fill,
        placeholder: (context, url) =>
        const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
