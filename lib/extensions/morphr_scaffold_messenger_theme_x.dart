import 'package:flutter/material.dart';
import 'package:morphr/adapters/figma_decoration_adapter.dart';
import 'package:morphr/morphr_service.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;

extension MorphrScaffoldMessengerThemeDataX on Scaffold {
  ScaffoldMessengerThemeData morph(String componentName) {
    if (componentName.isEmpty) {
      return this;
    }

    final node = MorphrService.instance.getComponent(componentName);
    if (node == null) return this;

    final decorationAdapter = FigmaDecorationAdapter(node);

    if (!decorationAdapter.supportsDecoration) {
      return this;
    }

    try {
      final decoration = decorationAdapter.createBoxDecoration();

      // Estrai colore di sfondo
      final Color? backgroundColor = decoration.color;

      // Estrai elevazione dalle ombre
      final List<BoxShadow>? shadows = decoration.boxShadow;
      double? elevation;
      if (shadows != null && shadows.isNotEmpty) {
        elevation = shadows.first.blurRadius / 2;
      }

      // Estrai forma dai bordi
      final BorderRadius? borderRadius =
          decoration.borderRadius as BorderRadius?;
      ShapeBorder? shape;
      if (borderRadius != null) {
        shape = RoundedRectangleBorder(borderRadius: borderRadius);
      }

      // Estrai padding dalla struttura del componente
      EdgeInsetsGeometry? padding;
      if (node is figma.Frame) {
        padding = EdgeInsets.fromLTRB(
          node.paddingLeft.toDouble(),
          node.paddingTop.toDouble(),
          node.paddingRight.toDouble(),
          node.paddingBottom.toDouble(),
        );
      } else if (node is figma.Instance) {
        padding = EdgeInsets.fromLTRB(
          node.paddingLeft.toDouble(),
          node.paddingTop.toDouble(),
          node.paddingRight.toDouble(),
          node.paddingBottom.toDouble(),
        );
      }

      // Calcola i margini in base ai padding specifici
      double? width;
      if (node is figma.Frame) {
        width = node.absoluteBoundingBox?.width?.toDouble();
      } else if (node is figma.Instance) {
        width = node.absoluteBoundingBox?.width?.toDouble();
      } else if (node is figma.Rectangle) {
        width = node.absoluteBoundingBox?.width?.toDouble();
      }

      EdgeInsetsGeometry? snackBarMargin;
      if (width != null) {
        // Calcoliamo un margine adeguato per il SnackBar, che di solito è proporzionale alla larghezza dello schermo
        final double horizontalMargin =
            width * 0.05; // 5% della larghezza come margine
        snackBarMargin = EdgeInsets.symmetric(
          horizontal: horizontalMargin,
          vertical: 10,
        );
      }

      // Per MaterialBanner, i margin di solito sono zero
      const EdgeInsetsGeometry materialBannerMargin = EdgeInsets.zero;

      // Crea lo SnackBarThemeData
      final SnackBarThemeData snackBarTheme = SnackBarThemeData(
        backgroundColor: backgroundColor,
        elevation: elevation,
        shape: shape,
        behavior: SnackBarBehavior.floating,
        contentTextStyle:
            null, // Come richiesto, non gestiamo gli stili di testo
        actionTextColor:
            null, // Come richiesto, non gestiamo gli stili di testo
        disabledActionTextColor:
            null, // Come richiesto, non gestiamo gli stili di testo
        padding: padding,
        width:
            null, // Lasciamo che Flutter calcoli la larghezza in base al contenuto
        insetPadding: snackBarMargin,
      );

      // Crea il MaterialBannerThemeData
      final MaterialBannerThemeData materialBannerTheme =
          MaterialBannerThemeData(
            backgroundColor: backgroundColor,
            elevation: elevation,
            shadowColor:
                shadows?.isNotEmpty == true ? shadows!.first.color : null,
            surfaceTintColor: null,
            dividerColor: null,
            padding: padding,
            leadingPadding: null,
          );

      return copyWith(
        snackBarTheme: this.snackBarTheme ?? snackBarTheme,
        materialBannerTheme: this.materialBannerTheme ?? materialBannerTheme,
      );
    } catch (_) {
      return this;
    }
  }
}
