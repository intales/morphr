import 'package:morphr/morphr.dart';
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
  const FigmaTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: GoogleFonts.robotoMono().fontFamily,
      ),
      home: Builder(
        builder: (context) {
          return Scaffold(
            body: Center(
              child: FigmaComponent.button(
                "button",
                onPressed: () => print("Hello, World!"),
                child: const Center(
                  child: FigmaComponent.text(
                    "button_text",
                    text: "Say hi!",
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
