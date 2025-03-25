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
            appBar: FigmaComponent.appBar(
              "app_bar",
              context: context,
              children: [
                const FigmaComponent.text(
                  "app_bar_title",
                  text: "Todo App",
                ),
                FigmaComponent.button(
                  "app_bar_add_todo_button",
                  onPressed: () {},
                ),
              ],
            ),
            bottomNavigationBar: const FigmaComponent.bottomBar(
              "bottom_bar",
              children: [
                Icon(Icons.home),
                Icon(Icons.task_rounded),
                Icon(Icons.add_task_outlined),
              ],
            ),
            body: FigmaComponent.container(
              "main_page",
              child: FigmaComponent.list(
                "todos_list",
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];

                  return FigmaComponent.row(
                    "todo_frame",
                    children: [
                      FigmaComponent.button(
                        "todo_checkbox${todo.done ? "_done" : ""}",
                        onPressed: () {},
                      ),
                      FigmaComponent.column(
                        "todo_frame_content",
                        children: [
                          FigmaComponent.text(
                            "todo_title",
                            text: todo.title,
                          ),
                          FigmaComponent.text(
                            "todo_description",
                            text: todo.description,
                          ),
                        ],
                      ),
                    ],
                  );
                },
                scrollDirection: Axis.vertical,
              ),
            ),
          );
        },
      ),
    );
  }
}
