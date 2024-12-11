import 'package:figflow/figflow.dart';
import 'package:flutter/material.dart';

void main() async {
  const token = String.fromEnvironment("TOKEN");
  const fileKey = String.fromEnvironment("FILE_KEY");

  await FigmaService.instance.initialize(
    accessToken: token,
    fileId: fileKey,
  );

  runApp(const FigmaTestApp());
}

class FigmaTestApp extends StatelessWidget {
  const FigmaTestApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        //backgroundColor: Colors.black,
        body: Center(
          child: TextExample(),
        ),
      ),
    );
  }
}

class TextExample extends FigmaComponent {
  const TextExample({super.key});

  @override
  String get figmaComponentId => "text_example";
}
