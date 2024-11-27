//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

part 'connector_endpoint.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ConnectorEndpoint {
  /// Returns a new [ConnectorEndpoint] instance.
  ConnectorEndpoint({

     this.endpointNodeId,

     this.magnet,
  });

  @JsonKey(
    
    name: r'endpointNodeId',
    required: false,
    includeIfNull: false,
  )


  final String? endpointNodeId;



  @JsonKey(
    
    name: r'magnet',
    required: false,
    includeIfNull: false,
  )


  final ConnectorEndpointMagnetEnum? magnet;





    @override
    bool operator ==(Object other) => identical(this, other) || other is ConnectorEndpoint &&
      other.endpointNodeId == endpointNodeId &&
      other.magnet == magnet;

    @override
    int get hashCode =>
        endpointNodeId.hashCode +
        magnet.hashCode;

  factory ConnectorEndpoint.fromJson(Map<String, dynamic> json) => _$ConnectorEndpointFromJson(json);

  Map<String, dynamic> toJson() => _$ConnectorEndpointToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}


enum ConnectorEndpointMagnetEnum {
@JsonValue(r'AUTO')
AUTO(r'AUTO'),
@JsonValue(r'TOP')
TOP(r'TOP'),
@JsonValue(r'BOTTOM')
BOTTOM(r'BOTTOM'),
@JsonValue(r'LEFT')
LEFT(r'LEFT'),
@JsonValue(r'RIGHT')
RIGHT(r'RIGHT'),
@JsonValue(r'CENTER')
CENTER(r'CENTER');

const ConnectorEndpointMagnetEnum(this.value);

final String value;

@override
String toString() => value;
}


