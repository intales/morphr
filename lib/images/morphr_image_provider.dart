import 'package:flutter/widgets.dart';

abstract class MorphrImageProvider {
  const MorphrImageProvider();

  ImageProvider getImageForRef(String imageRef);
}

mixin MorphrImagePreloader on MorphrImageProvider {
  Future<void> preloadImages();
}
