import 'package:morphr/morphr.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FigmaService.instance.initialize(
    documentPath: 'assets/figma_document.json',
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
          return const Scaffold(
            body: SafeArea(
              child: FigmaComponent.row(
                "toolbar",
                children: [
                  FigmaComponent.icon("search"),
                  FigmaComponent.icon("notifications"),
                  FigmaComponent.icon("profile"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
