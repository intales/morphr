import 'package:dart_mappable/dart_mappable.dart';

@MappableClass()
class MorphrComponent {
  final String componentName;
  final String type;
  final String properties;

  const MorphrComponent({
    required this.componentName,
    required this.type,
    required this.properties,
  });
}
