import 'package:figflow/figflow.dart';
import 'package:flutter/material.dart';
import 'package:figma/figma.dart' as figma_api;

void main() async {
  const token = String.fromEnvironment("TOKEN");
  const fileKey = String.fromEnvironment("FILE_KEY");

  final client = figma_api.FigmaClient(token);

  final document = await client.getFile(fileKey);

  final root = document.document!;

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
        backgroundColor: const Color(0xFF222222),
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
