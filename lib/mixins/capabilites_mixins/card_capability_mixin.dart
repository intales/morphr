import 'package:flutter/material.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;

mixin CardCapability {
  Widget buildFromCard(Card card, figma.Node node) {
    return Card(
      key: card.key,
      color: extractBackgroundColor(node) ?? card.color,
      shadowColor: extractShadowColor(node) ?? card.shadowColor,
      elevation: extractElevation(node) ?? card.elevation,
      shape: extractShape(node) ?? card.shape,
      borderOnForeground: card.borderOnForeground,
      margin: card.margin,
      clipBehavior: card.clipBehavior,
      child: card.child,
    );
  }

  // These methods will be provided by DecorationCapability
  Color? extractBackgroundColor(figma.Node node);
  Color? extractShadowColor(figma.Node node);
  double? extractElevation(figma.Node node);
  ShapeBorder? extractShape(figma.Node node);
}
