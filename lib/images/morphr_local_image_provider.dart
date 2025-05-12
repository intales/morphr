import 'package:flutter/widgets.dart';
import 'package:morphr/images/morphr_image_provider.dart';

class MorphrLocalImageProvider implements MorphrImageProvider {
  const MorphrLocalImageProvider();

  static const String _assetBundleImagesPath = "assets/morphr/images";

  @override
  ImageProvider getImageForRef(String imageRef) {
    return AssetImage("$_assetBundleImagesPath/$imageRef");
  }
}
