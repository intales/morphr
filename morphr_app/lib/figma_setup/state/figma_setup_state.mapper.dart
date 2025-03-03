// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'figma_setup_state.dart';

class FigmaSetupStateMapper extends ClassMapperBase<FigmaSetupState> {
  FigmaSetupStateMapper._();

  static FigmaSetupStateMapper? _instance;
  static FigmaSetupStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FigmaSetupStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'FigmaSetupState';

  static String _$figmaFileUrl(FigmaSetupState v) => v.figmaFileUrl;
  static const Field<FigmaSetupState, String> _f$figmaFileUrl =
      Field('figmaFileUrl', _$figmaFileUrl, opt: true, def: "");
  static String _$figmaAccessToken(FigmaSetupState v) => v.figmaAccessToken;
  static const Field<FigmaSetupState, String> _f$figmaAccessToken =
      Field('figmaAccessToken', _$figmaAccessToken, opt: true, def: "");
  static bool _$documentLoaded(FigmaSetupState v) => v.documentLoaded;
  static const Field<FigmaSetupState, bool> _f$documentLoaded =
      Field('documentLoaded', _$documentLoaded, opt: true, def: false);
  static figma.Document? _$document(FigmaSetupState v) => v.document;
  static const Field<FigmaSetupState, figma.Document> _f$document =
      Field('document', _$document, opt: true);

  @override
  final MappableFields<FigmaSetupState> fields = const {
    #figmaFileUrl: _f$figmaFileUrl,
    #figmaAccessToken: _f$figmaAccessToken,
    #documentLoaded: _f$documentLoaded,
    #document: _f$document,
  };

  static FigmaSetupState _instantiate(DecodingData data) {
    return FigmaSetupState(
        figmaFileUrl: data.dec(_f$figmaFileUrl),
        figmaAccessToken: data.dec(_f$figmaAccessToken),
        documentLoaded: data.dec(_f$documentLoaded),
        document: data.dec(_f$document));
  }

  @override
  final Function instantiate = _instantiate;

  static FigmaSetupState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FigmaSetupState>(map);
  }

  static FigmaSetupState fromJson(String json) {
    return ensureInitialized().decodeJson<FigmaSetupState>(json);
  }
}

mixin FigmaSetupStateMappable {
  String toJson() {
    return FigmaSetupStateMapper.ensureInitialized()
        .encodeJson<FigmaSetupState>(this as FigmaSetupState);
  }

  Map<String, dynamic> toMap() {
    return FigmaSetupStateMapper.ensureInitialized()
        .encodeMap<FigmaSetupState>(this as FigmaSetupState);
  }

  FigmaSetupStateCopyWith<FigmaSetupState, FigmaSetupState, FigmaSetupState>
      get copyWith => _FigmaSetupStateCopyWithImpl(
          this as FigmaSetupState, $identity, $identity);
  @override
  String toString() {
    return FigmaSetupStateMapper.ensureInitialized()
        .stringifyValue(this as FigmaSetupState);
  }

  @override
  bool operator ==(Object other) {
    return FigmaSetupStateMapper.ensureInitialized()
        .equalsValue(this as FigmaSetupState, other);
  }

  @override
  int get hashCode {
    return FigmaSetupStateMapper.ensureInitialized()
        .hashValue(this as FigmaSetupState);
  }
}

extension FigmaSetupStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FigmaSetupState, $Out> {
  FigmaSetupStateCopyWith<$R, FigmaSetupState, $Out> get $asFigmaSetupState =>
      $base.as((v, t, t2) => _FigmaSetupStateCopyWithImpl(v, t, t2));
}

abstract class FigmaSetupStateCopyWith<$R, $In extends FigmaSetupState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? figmaFileUrl,
      String? figmaAccessToken,
      bool? documentLoaded,
      figma.Document? document});
  FigmaSetupStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _FigmaSetupStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FigmaSetupState, $Out>
    implements FigmaSetupStateCopyWith<$R, FigmaSetupState, $Out> {
  _FigmaSetupStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FigmaSetupState> $mapper =
      FigmaSetupStateMapper.ensureInitialized();
  @override
  $R call(
          {String? figmaFileUrl,
          String? figmaAccessToken,
          bool? documentLoaded,
          Object? document = $none}) =>
      $apply(FieldCopyWithData({
        if (figmaFileUrl != null) #figmaFileUrl: figmaFileUrl,
        if (figmaAccessToken != null) #figmaAccessToken: figmaAccessToken,
        if (documentLoaded != null) #documentLoaded: documentLoaded,
        if (document != $none) #document: document
      }));
  @override
  FigmaSetupState $make(CopyWithData data) => FigmaSetupState(
      figmaFileUrl: data.get(#figmaFileUrl, or: $value.figmaFileUrl),
      figmaAccessToken:
          data.get(#figmaAccessToken, or: $value.figmaAccessToken),
      documentLoaded: data.get(#documentLoaded, or: $value.documentLoaded),
      document: data.get(#document, or: $value.document));

  @override
  FigmaSetupStateCopyWith<$R2, FigmaSetupState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _FigmaSetupStateCopyWithImpl($value, $cast, t);
}
