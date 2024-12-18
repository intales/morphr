import 'package:morphr/figma_property_scope.dart';
import 'package:flutter/widgets.dart';

class FigmaComponentContext {
  final BuildContext buildContext;
  final Map<String, dynamic> properties;
  final List<FigmaPropertyScope>? propertyScopes;

  const FigmaComponentContext({
    required this.buildContext,
    required this.properties,
    this.propertyScopes,
  });

  T? get<T>(String propertyKey, {required String nodeId}) {
    if (propertyScopes != null) {
      final scope = propertyScopes!.firstWhere(
        (scope) => scope.nodeId == nodeId,
        orElse: () => FigmaPropertyScope(nodeId: nodeId, properties: const {}),
      );

      final scopedValue = scope.properties[propertyKey];
      if (scopedValue != null && scopedValue is T) {
        return scopedValue;
      }
    }

    final value = properties[propertyKey];
    if (value != null && value is T) {
      return value;
    }

    return null;
  }
}
