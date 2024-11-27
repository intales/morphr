//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

part 'get_images200_response.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class GetImages200Response {
  /// Returns a new [GetImages200Response] instance.
  GetImages200Response({

     this.images,
  });

  @JsonKey(
    
    name: r'images',
    required: false,
    includeIfNull: false,
  )


  final Map<String, String>? images;





    @override
    bool operator ==(Object other) => identical(this, other) || other is GetImages200Response &&
      other.images == images;

    @override
    int get hashCode =>
        images.hashCode;

  factory GetImages200Response.fromJson(Map<String, dynamic> json) => _$GetImages200ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetImages200ResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

