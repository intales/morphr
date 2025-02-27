// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'package:figma/figma.dart' as figma;
import 'package:morphr/adapters/figma_decoration_adapter.dart';
import 'package:morphr/adapters/figma_shape_adapter.dart';
import 'package:morphr/compilers/morphr_compiler.dart';
import 'package:morphr/compilers/morphr_component.dart';
import 'package:morphr/extensions/flutter_extensions.dart';

class MorphrShapeCompiler implements MorphrCompiler {
  @override
  MorphrComponent compile(figma.Node node) {
    final shapeAdapter = FigmaShapeAdapter(node);
    final decorationAdapter = FigmaDecorationAdapter(node);

    shapeAdapter.validateShape();
    decorationAdapter.validateDecoration();

    final component = MorphrComponent(
      componentName: node.name!,
      type: "shape",
      properties: {
        "width": shapeAdapter.size?.width,
        "height": shapeAdapter.size?.height,
        "decoration": decorationAdapter.createBoxDecoration().toJson(),
      },
    );

    return component;
  }
}
