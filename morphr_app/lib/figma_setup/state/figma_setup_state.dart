import 'package:figma/figma.dart' as figma;
import 'package:dart_mappable/dart_mappable.dart';
import 'package:minimal_mvn/minimal_mvn.dart';

part 'figma_setup_state.mapper.dart';

@MappableClass()
class FigmaSetupState extends MMState with FigmaSetupStateMappable {
  const FigmaSetupState({
    this.figmaFileUrl = "",
    this.figmaAccessToken = "",
    this.documentLoaded = false,
    this.document,
  });

  final String figmaFileUrl;
  final String figmaAccessToken;
  final bool documentLoaded;
  final figma.Document? document;

  bool get canSubmit => figmaFileUrl.isNotEmpty && figmaAccessToken.isNotEmpty;
}
