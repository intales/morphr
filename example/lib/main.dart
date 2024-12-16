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
      home: Scaffold(
        body: Center(
          child: FigmaComponent(
            componentId: "main_page",
            recursive: true,
            overrides: [
              const FigmaOverride(
                nodeId: "email_text_field",
                properties: {
                  FigmaProperties.isInput: true,
                },
              ),
              FigmaOverride(
                nodeId: "main_page",
                properties: {
                  FigmaProperties.width: MediaQuery.of(context).size.width,
                  FigmaProperties.height: MediaQuery.of(context).size.height,
                  FigmaProperties.fit: FigmaFrameFit.cover,
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
