import 'package:flutter/material.dart';
import 'package:morphr/adapters/figma_text_adapter.dart';
import 'package:morphr/archetypes/widget_archetype.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;

mixin TextCapability {
  Capability get isText => (Widget widget) {
    return widget is Text || widget is RichText;
  };

  TextStyle? extractTextStyle(figma.Node node) {
    final figmaText = FigmaTextAdapter(node);
    return figmaText.createTextStyle();
  }

  TextAlign? extractTextAlign(figma.Node node) {
    final figmaText = FigmaTextAdapter(node);
    return figmaText.getTextAlign();
  }

  Widget buildFromText(Text text, figma.Node node) {
    final figmaText = FigmaTextAdapter(node);

    if (!figmaText.supportsText) return text;

    return Text(
      text.data ?? '',
      key: text.key,
      style: figmaText.createTextStyle()?.merge(text.style),
      textAlign: figmaText.getTextAlign(),
      overflow: text.overflow,
      maxLines: text.maxLines,
      softWrap: text.softWrap,
      textScaler: text.textScaler,
      semanticsLabel: text.semanticsLabel,
      textWidthBasis: text.textWidthBasis,
      textHeightBehavior: text.textHeightBehavior,
    );
  }

  Widget buildFromRichText(RichText richText, figma.Node node) {
    final figmaText = FigmaTextAdapter(node);

    if (!figmaText.supportsText) return richText;

    return RichText(
      key: richText.key,
      text: richText.text,
      textAlign: figmaText.getTextAlign(),
      overflow: richText.overflow,
      maxLines: richText.maxLines,
      softWrap: richText.softWrap,
      textScaler: richText.textScaler,
      textWidthBasis: richText.textWidthBasis,
      textHeightBehavior: richText.textHeightBehavior,
    );
  }
}
