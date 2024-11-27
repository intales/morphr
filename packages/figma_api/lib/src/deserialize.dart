import 'package:figma_api/src/model/boolean_operation.dart';
import 'package:figma_api/src/model/canvas.dart';
import 'package:figma_api/src/model/color.dart';
import 'package:figma_api/src/model/color_stop.dart';
import 'package:figma_api/src/model/component_property.dart';
import 'package:figma_api/src/model/connector_endpoint.dart';
import 'package:figma_api/src/model/connector_properties.dart';
import 'package:figma_api/src/model/constraint.dart';
import 'package:figma_api/src/model/document.dart';
import 'package:figma_api/src/model/effect.dart';
import 'package:figma_api/src/model/export_setting.dart';
import 'package:figma_api/src/model/get_file200_response.dart';
import 'package:figma_api/src/model/get_images200_response.dart';
import 'package:figma_api/src/model/layout_constraint.dart';
import 'package:figma_api/src/model/layout_grid.dart';
import 'package:figma_api/src/model/node.dart';
import 'package:figma_api/src/model/paint.dart';
import 'package:figma_api/src/model/path.dart';
import 'package:figma_api/src/model/rectangle.dart';
import 'package:figma_api/src/model/style.dart';
import 'package:figma_api/src/model/table_properties.dart';
import 'package:figma_api/src/model/type_style.dart';
import 'package:figma_api/src/model/vector.dart';
import 'package:figma_api/src/model/vector_properties.dart';

final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

  ReturnType deserialize<ReturnType, BaseType>(dynamic value, String targetType, {bool growable= true}) {
      switch (targetType) {
        case 'String':
          return '$value' as ReturnType;
        case 'int':
          return (value is int ? value : int.parse('$value')) as ReturnType;
        case 'bool':
          if (value is bool) {
            return value as ReturnType;
          }
          final valueString = '$value'.toLowerCase();
          return (valueString == 'true' || valueString == '1') as ReturnType;
        case 'double':
          return (value is double ? value : double.parse('$value')) as ReturnType;
        case 'BlendMode':
          
          
        case 'BooleanOperation':
          return BooleanOperation.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'Canvas':
          return Canvas.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'Color':
          return Color.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ColorStop':
          return ColorStop.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ComponentProperty':
          return ComponentProperty.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ConnectorEndpoint':
          return ConnectorEndpoint.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ConnectorProperties':
          return ConnectorProperties.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'Constraint':
          return Constraint.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'Document':
          return Document.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'EasingType':
          
          
        case 'Effect':
          return Effect.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ExportSetting':
          return ExportSetting.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'GetFile200Response':
          return GetFile200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'GetImages200Response':
          return GetImages200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'LayoutConstraint':
          return LayoutConstraint.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'LayoutGrid':
          return LayoutGrid.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'Node':
          return Node.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'Paint':
          return Paint.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'Path':
          return Path.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'Rectangle':
          return Rectangle.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'Style':
          return Style.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'TableProperties':
          return TableProperties.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'TypeStyle':
          return TypeStyle.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'Vector':
          return Vector.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'VectorProperties':
          return VectorProperties.fromJson(value as Map<String, dynamic>) as ReturnType;
        default:
          RegExpMatch? match;

          if (value is List && (match = _regList.firstMatch(targetType)) != null) {
            targetType = match![1]!; // ignore: parameter_assignments
            return value
              .map<BaseType>((dynamic v) => deserialize<BaseType, BaseType>(v, targetType, growable: growable))
              .toList(growable: growable) as ReturnType;
          }
          if (value is Set && (match = _regSet.firstMatch(targetType)) != null) {
            targetType = match![1]!; // ignore: parameter_assignments
            return value
              .map<BaseType>((dynamic v) => deserialize<BaseType, BaseType>(v, targetType, growable: growable))
              .toSet() as ReturnType;
          }
          if (value is Map && (match = _regMap.firstMatch(targetType)) != null) {
            targetType = match![1]!.trim(); // ignore: parameter_assignments
            return Map<String, BaseType>.fromIterables(
              value.keys as Iterable<String>,
              value.values.map((dynamic v) => deserialize<BaseType, BaseType>(v, targetType, growable: growable)),
            ) as ReturnType;
          }
          break;
    }
    throw Exception('Cannot deserialize');
  }