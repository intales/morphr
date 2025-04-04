import 'package:example/morphr_options.dart';
import 'package:morphr/morphr.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MorphrService.instance.initializeCloud(options: morphrOptions);

  runApp(const FigmaTestApp());
}

class Todo {
  final String title;
  final String description;
  final bool done;

  const Todo({
    required this.title,
    required this.description,
    required this.done,
  });
}

final todos = List.generate(
  300,
  (index) => Todo(
    title: "Todo #${index + 1}",
    description: "Todo description #${index + 1}",
    done: index % 2 == 0,
  ),
);

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
            backgroundColor: Colors.white,
            body: SafeArea(
              child: FigmaComponent.tree("main_page"),
            ),
          );
        },
      ),
    );
  }
}
