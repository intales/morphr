import 'package:flutter/widgets.dart';

class FigmaComponentContext {
  final BuildContext buildContext;
  final Map<String, dynamic> properties;

  const FigmaComponentContext({
    required this.buildContext,
    required this.properties,
  });

  T? get<T>(String key) => properties[key] as T?;
}
