import 'package:morphr/compilers/morphr_component.dart';
import 'package:figma/figma.dart' as figma;

abstract class MorphrCompiler {
  MorphrComponent compile(figma.Node node);
}
