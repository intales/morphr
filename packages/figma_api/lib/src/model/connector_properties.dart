//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:figma_api/src/model/connector_endpoint.dart';
import 'package:json_annotation/json_annotation.dart';

part 'connector_properties.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ConnectorProperties {
  /// Returns a new [ConnectorProperties] instance.
  ConnectorProperties({

     this.connectorStart,

     this.connectorEnd,

     this.connectorLineType,
  });

  @JsonKey(
    
    name: r'connectorStart',
    required: false,
    includeIfNull: false,
  )


  final ConnectorEndpoint? connectorStart;



  @JsonKey(
    
    name: r'connectorEnd',
    required: false,
    includeIfNull: false,
  )


  final ConnectorEndpoint? connectorEnd;



  @JsonKey(
    
    name: r'connectorLineType',
    required: false,
    includeIfNull: false,
  )


  final ConnectorPropertiesConnectorLineTypeEnum? connectorLineType;





    @override
    bool operator ==(Object other) => identical(this, other) || other is ConnectorProperties &&
      other.connectorStart == connectorStart &&
      other.connectorEnd == connectorEnd &&
      other.connectorLineType == connectorLineType;

    @override
    int get hashCode =>
        connectorStart.hashCode +
        connectorEnd.hashCode +
        connectorLineType.hashCode;

  factory ConnectorProperties.fromJson(Map<String, dynamic> json) => _$ConnectorPropertiesFromJson(json);

  Map<String, dynamic> toJson() => _$ConnectorPropertiesToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}


enum ConnectorPropertiesConnectorLineTypeEnum {
@JsonValue(r'STRAIGHT')
STRAIGHT(r'STRAIGHT'),
@JsonValue(r'ELBOWED')
ELBOWED(r'ELBOWED');

const ConnectorPropertiesConnectorLineTypeEnum(this.value);

final String value;

@override
String toString() => value;
}


