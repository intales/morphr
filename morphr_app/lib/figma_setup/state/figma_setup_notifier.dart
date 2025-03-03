import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:minimal_mvn/minimal_mvn.dart';
import 'package:figma/figma.dart' as figma;
import 'package:morphr_app/figma_setup/state/figma_setup_state.dart';

class FigmaSetupNotifier extends MMNotifier<FigmaSetupState> {
  FigmaSetupNotifier() : super(const FigmaSetupState());

  void updateFigmaFileUrl(String figmaFileUrl) =>
      notify(state.copyWith(figmaFileUrl: figmaFileUrl));

  void updateFigmaAccessToken(String figmaAccessToken) =>
      notify(state.copyWith(figmaAccessToken: figmaAccessToken));

  Future<void> getFigmaFile() async {
    final document = await _loadFigmaFile();
    notify(state.copyWith(documentLoaded: true, document: document));
  }

  Future<figma.Document> _loadFigmaFile() async {
    final fileId = _extractFigmaProjectId(state.figmaFileUrl);
    final response = await http.get(
      Uri.parse("https://api.figma.com/v1/files/$fileId?geometry=paths"),
      headers: {
        "Content-Type": "application/json",
        "X-Figma-Token": state.figmaAccessToken,
      },
    );

    if (response.statusCode != 200) {
      throw response.body;
    }

    return figma.FileResponse.fromJson(jsonDecode(response.body)).document
        as figma.Document;
  }

  String _extractFigmaProjectId(String figmaUrl) {
    if (figmaUrl.isEmpty) {
      throw ArgumentError('Figma URL cannot be empty');
    }

    final regExp = RegExp(r'(?:design|file)/([a-zA-Z0-9]+)');
    final match = regExp.firstMatch(figmaUrl);

    if (match != null && match.groupCount >= 1) {
      return match.group(1)!;
    } else {
      throw FormatException('Invalid URL format: $figmaUrl');
    }
  }
}

final MMManager<FigmaSetupNotifier> figmaSetupManager = MMManager(
  FigmaSetupNotifier.new,
  autodispose: true,
);
