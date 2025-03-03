import 'package:flutter/material.dart';
import 'package:morphr_app/router.dart';

void main() {
  runApp(const MorphrApp());
}

class MorphrApp extends StatelessWidget {
  const MorphrApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Morphr',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0XFFE879F9),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
