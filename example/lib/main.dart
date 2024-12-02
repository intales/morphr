import 'package:figflow/figflow.dart';
import 'package:flutter/material.dart';
import 'package:figma/figma.dart' as figma_api;

void main() async {
  const token = String.fromEnvironment("TOKEN");
  const fileKey = String.fromEnvironment("FILE_KEY");

  final client = figma_api.FigmaClient(token);

  final document = await client.getFile(fileKey);
  final canvas = (document.document?.children?.first as figma_api.Canvas);

  final root = canvas.children?.first;
  if (root == null) throw Exception("Unable to find root node.");

  runApp(FigmaTestApp(
    node: root,
  ));
}

class FigmaTestApp extends StatelessWidget {
  const FigmaTestApp({
    required this.node,
    super.key,
  });

  final figma_api.Node node;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Figma Layout + Rectangle Tests',
          ),
        ),
        body: FigmaConverter().convertNode(node),
      ),
    );
  }
}
