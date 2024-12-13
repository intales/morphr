import 'package:figflow/figflow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return MaterialApp(
      theme: ThemeData(
        fontFamily: GoogleFonts.robotoMono().fontFamily,
      ),
      home: const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: FigmaComponent(
            componentId: "main_page",
            recursive: true,
            overrides: [
              FigmaOverride(
                nodeId: "headline",
                properties: {
                  FigmaProperties.text: "Buon compleanno Elia!",
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
