import 'package:morphr/morphr.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MorphrService.instance
      .initialize(documentPath: "assets/morphr/design.json");

  runApp(const FigmaTestApp());
}

class FigmaTestApp extends StatelessWidget {
  const FigmaTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: FigmaComponent.widget("outer_wilds 1"),
        ),
      ),
    );
  }
}
