// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connector_properties.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConnectorProperties _$ConnectorPropertiesFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ConnectorProperties',
      json,
      ($checkedConvert) {
        final val = ConnectorProperties(
          connectorStart: $checkedConvert(
              'connectorStart',
              (v) => v == null
                  ? null
                  : ConnectorEndpoint.fromJson(v as Map<String, dynamic>)),
          connectorEnd: $checkedConvert(
              'connectorEnd',
              (v) => v == null
                  ? null
                  : ConnectorEndpoint.fromJson(v as Map<String, dynamic>)),
          connectorLineType: $checkedConvert(
              'connectorLineType',
              (v) => $enumDecodeNullable(
                  _$ConnectorPropertiesConnectorLineTypeEnumEnumMap, v)),
        );
        return val;
      },
    );

Map<String, dynamic> _$ConnectorPropertiesToJson(
        ConnectorProperties instance) =>
    <String, dynamic>{
      if (instance.connectorStart?.toJson() case final value?)
        'connectorStart': value,
      if (instance.connectorEnd?.toJson() case final value?)
        'connectorEnd': value,
      if (_$ConnectorPropertiesConnectorLineTypeEnumEnumMap[
              instance.connectorLineType]
          case final value?)
        'connectorLineType': value,
    };

const _$ConnectorPropertiesConnectorLineTypeEnumEnumMap = {
  ConnectorPropertiesConnectorLineTypeEnum.STRAIGHT: 'STRAIGHT',
  ConnectorPropertiesConnectorLineTypeEnum.ELBOWED: 'ELBOWED',
};
