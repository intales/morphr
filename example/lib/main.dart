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

  Todo get toggle => Todo(title: title, description: description, done: !done);
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
      home: FigmaComponent.scaffold(
        "todos_list",
        appBarNodeName: "app_bar",
        appBarTransformers: [
          replaceText("app_bar_title", "Bentornato Elia"),
        ],
        bodyTransformers: [
          widgetTransformer(
            "todos_list",
            builder: (context) {
              return FigmaComponent.list(
                "todos_list",
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  final done = todo.done ? "_done" : "";
                  return FigmaComponent.widget(
                    "todo_frame$done",
                    transformers: [
                      onTap("todo_frame$done", () => print("hello")),
                      replaceText("todo_title$done", todo.title),
                      replaceText("todo_description$done", todo.description),
                    ],
                  );
                },
                scrollDirection: Axis.vertical,
                shrinkWrap: false,
              );
            },
          ),
        ],
      ),
    );
  }
}
