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

class FigmaTestApp extends StatefulWidget {
  const FigmaTestApp({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _FigmaTestAppState();
}

class _FigmaTestAppState extends State<FigmaTestApp> {
  late final TextEditingController _controller;
  late String _email;

  @override
  void initState() {
    super.initState();
    _email = "";
    _controller = TextEditingController()
      ..addListener(() => setState(() {
            _email = _controller.text;
          }));
  }

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
              FigmaOverride(
                nodeId: "email_text_field",
                properties: {
                  FigmaProperties.isTextField: true,
                  FigmaProperties.controller: _controller,
                },
              ),
              FigmaOverride(
                nodeId: "join_button",
                properties: {
                  FigmaProperties.onTap: () => print(_email),
                },
              ),
              FigmaOverride(
                nodeId: "join_button_text",
                properties: {
                  FigmaProperties.onTap: () => print(_email),
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
