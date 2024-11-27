// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connector_endpoint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConnectorEndpoint _$ConnectorEndpointFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ConnectorEndpoint',
      json,
      ($checkedConvert) {
        final val = ConnectorEndpoint(
          endpointNodeId:
              $checkedConvert('endpointNodeId', (v) => v as String?),
          magnet: $checkedConvert(
              'magnet',
              (v) =>
                  $enumDecodeNullable(_$ConnectorEndpointMagnetEnumEnumMap, v)),
        );
        return val;
      },
    );

Map<String, dynamic> _$ConnectorEndpointToJson(ConnectorEndpoint instance) =>
    <String, dynamic>{
      if (instance.endpointNodeId case final value?) 'endpointNodeId': value,
      if (_$ConnectorEndpointMagnetEnumEnumMap[instance.magnet]
          case final value?)
        'magnet': value,
    };

const _$ConnectorEndpointMagnetEnumEnumMap = {
  ConnectorEndpointMagnetEnum.AUTO: 'AUTO',
  ConnectorEndpointMagnetEnum.TOP: 'TOP',
  ConnectorEndpointMagnetEnum.BOTTOM: 'BOTTOM',
  ConnectorEndpointMagnetEnum.LEFT: 'LEFT',
  ConnectorEndpointMagnetEnum.RIGHT: 'RIGHT',
  ConnectorEndpointMagnetEnum.CENTER: 'CENTER',
};
