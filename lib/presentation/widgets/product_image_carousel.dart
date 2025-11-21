import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductImageCarousel extends StatelessWidget {
  final List<String> images;

  const ProductImageCarousel({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return const SizedBox(
        height: 300,
        child: Center(child: Icon(Icons.image, size: 100)),
      );
    }

    return SizedBox(
      height: 400,
      child: PageView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          return CachedNetworkImage(
            imageUrl: images[index],
            fit: BoxFit.cover,
            width: double.infinity,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          );
        },
      ),
    );
  }
}

