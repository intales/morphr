//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:figma_api/src/model/document.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_file200_response.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class GetFile200Response {
  /// Returns a new [GetFile200Response] instance.
  GetFile200Response({

     this.name,

     this.lastModified,

     this.version,

     this.document,
  });

  @JsonKey(
    
    name: r'name',
    required: false,
    includeIfNull: false,
  )


  final String? name;



  @JsonKey(
    
    name: r'lastModified',
    required: false,
    includeIfNull: false,
  )


  final DateTime? lastModified;



  @JsonKey(
    
    name: r'version',
    required: false,
    includeIfNull: false,
  )


  final String? version;



  @JsonKey(
    
    name: r'document',
    required: false,
    includeIfNull: false,
  )


  final Document? document;





    @override
    bool operator ==(Object other) => identical(this, other) || other is GetFile200Response &&
      other.name == name &&
      other.lastModified == lastModified &&
      other.version == version &&
      other.document == document;

    @override
    int get hashCode =>
        name.hashCode +
        lastModified.hashCode +
        version.hashCode +
        document.hashCode;

  factory GetFile200Response.fromJson(Map<String, dynamic> json) => _$GetFile200ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetFile200ResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

