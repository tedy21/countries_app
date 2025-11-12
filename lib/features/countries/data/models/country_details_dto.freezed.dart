// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'country_details_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CountryDetailsDto _$CountryDetailsDtoFromJson(Map<String, dynamic> json) {
  return _CountryDetailsDto.fromJson(json);
}

/// @nodoc
mixin _$CountryDetailsDto {
  NameDto get name => throw _privateConstructorUsedError;
  FlagsDto get flags => throw _privateConstructorUsedError;
  int get population => throw _privateConstructorUsedError;
  String get cca2 => throw _privateConstructorUsedError;
  List<String> get capital => throw _privateConstructorUsedError;
  String get region => throw _privateConstructorUsedError;
  String get subregion => throw _privateConstructorUsedError;
  double? get area => throw _privateConstructorUsedError;
  List<String> get timezones => throw _privateConstructorUsedError;

  /// Serializes this CountryDetailsDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CountryDetailsDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CountryDetailsDtoCopyWith<CountryDetailsDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CountryDetailsDtoCopyWith<$Res> {
  factory $CountryDetailsDtoCopyWith(
          CountryDetailsDto value, $Res Function(CountryDetailsDto) then) =
      _$CountryDetailsDtoCopyWithImpl<$Res, CountryDetailsDto>;
  @useResult
  $Res call(
      {NameDto name,
      FlagsDto flags,
      int population,
      String cca2,
      List<String> capital,
      String region,
      String subregion,
      double? area,
      List<String> timezones});

  $NameDtoCopyWith<$Res> get name;
  $FlagsDtoCopyWith<$Res> get flags;
}

/// @nodoc
class _$CountryDetailsDtoCopyWithImpl<$Res, $Val extends CountryDetailsDto>
    implements $CountryDetailsDtoCopyWith<$Res> {
  _$CountryDetailsDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CountryDetailsDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? flags = null,
    Object? population = null,
    Object? cca2 = null,
    Object? capital = null,
    Object? region = null,
    Object? subregion = null,
    Object? area = freezed,
    Object? timezones = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as NameDto,
      flags: null == flags
          ? _value.flags
          : flags // ignore: cast_nullable_to_non_nullable
              as FlagsDto,
      population: null == population
          ? _value.population
          : population // ignore: cast_nullable_to_non_nullable
              as int,
      cca2: null == cca2
          ? _value.cca2
          : cca2 // ignore: cast_nullable_to_non_nullable
              as String,
      capital: null == capital
          ? _value.capital
          : capital // ignore: cast_nullable_to_non_nullable
              as List<String>,
      region: null == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String,
      subregion: null == subregion
          ? _value.subregion
          : subregion // ignore: cast_nullable_to_non_nullable
              as String,
      area: freezed == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as double?,
      timezones: null == timezones
          ? _value.timezones
          : timezones // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }

  /// Create a copy of CountryDetailsDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NameDtoCopyWith<$Res> get name {
    return $NameDtoCopyWith<$Res>(_value.name, (value) {
      return _then(_value.copyWith(name: value) as $Val);
    });
  }

  /// Create a copy of CountryDetailsDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FlagsDtoCopyWith<$Res> get flags {
    return $FlagsDtoCopyWith<$Res>(_value.flags, (value) {
      return _then(_value.copyWith(flags: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CountryDetailsDtoImplCopyWith<$Res>
    implements $CountryDetailsDtoCopyWith<$Res> {
  factory _$$CountryDetailsDtoImplCopyWith(_$CountryDetailsDtoImpl value,
          $Res Function(_$CountryDetailsDtoImpl) then) =
      __$$CountryDetailsDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {NameDto name,
      FlagsDto flags,
      int population,
      String cca2,
      List<String> capital,
      String region,
      String subregion,
      double? area,
      List<String> timezones});

  @override
  $NameDtoCopyWith<$Res> get name;
  @override
  $FlagsDtoCopyWith<$Res> get flags;
}

/// @nodoc
class __$$CountryDetailsDtoImplCopyWithImpl<$Res>
    extends _$CountryDetailsDtoCopyWithImpl<$Res, _$CountryDetailsDtoImpl>
    implements _$$CountryDetailsDtoImplCopyWith<$Res> {
  __$$CountryDetailsDtoImplCopyWithImpl(_$CountryDetailsDtoImpl _value,
      $Res Function(_$CountryDetailsDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of CountryDetailsDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? flags = null,
    Object? population = null,
    Object? cca2 = null,
    Object? capital = null,
    Object? region = null,
    Object? subregion = null,
    Object? area = freezed,
    Object? timezones = null,
  }) {
    return _then(_$CountryDetailsDtoImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as NameDto,
      flags: null == flags
          ? _value.flags
          : flags // ignore: cast_nullable_to_non_nullable
              as FlagsDto,
      population: null == population
          ? _value.population
          : population // ignore: cast_nullable_to_non_nullable
              as int,
      cca2: null == cca2
          ? _value.cca2
          : cca2 // ignore: cast_nullable_to_non_nullable
              as String,
      capital: null == capital
          ? _value._capital
          : capital // ignore: cast_nullable_to_non_nullable
              as List<String>,
      region: null == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String,
      subregion: null == subregion
          ? _value.subregion
          : subregion // ignore: cast_nullable_to_non_nullable
              as String,
      area: freezed == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as double?,
      timezones: null == timezones
          ? _value._timezones
          : timezones // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CountryDetailsDtoImpl implements _CountryDetailsDto {
  const _$CountryDetailsDtoImpl(
      {required this.name,
      required this.flags,
      required this.population,
      required this.cca2,
      final List<String> capital = const [],
      this.region = '',
      this.subregion = '',
      this.area,
      final List<String> timezones = const []})
      : _capital = capital,
        _timezones = timezones;

  factory _$CountryDetailsDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CountryDetailsDtoImplFromJson(json);

  @override
  final NameDto name;
  @override
  final FlagsDto flags;
  @override
  final int population;
  @override
  final String cca2;
  final List<String> _capital;
  @override
  @JsonKey()
  List<String> get capital {
    if (_capital is EqualUnmodifiableListView) return _capital;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_capital);
  }

  @override
  @JsonKey()
  final String region;
  @override
  @JsonKey()
  final String subregion;
  @override
  final double? area;
  final List<String> _timezones;
  @override
  @JsonKey()
  List<String> get timezones {
    if (_timezones is EqualUnmodifiableListView) return _timezones;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_timezones);
  }

  @override
  String toString() {
    return 'CountryDetailsDto(name: $name, flags: $flags, population: $population, cca2: $cca2, capital: $capital, region: $region, subregion: $subregion, area: $area, timezones: $timezones)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CountryDetailsDtoImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.flags, flags) || other.flags == flags) &&
            (identical(other.population, population) ||
                other.population == population) &&
            (identical(other.cca2, cca2) || other.cca2 == cca2) &&
            const DeepCollectionEquality().equals(other._capital, _capital) &&
            (identical(other.region, region) || other.region == region) &&
            (identical(other.subregion, subregion) ||
                other.subregion == subregion) &&
            (identical(other.area, area) || other.area == area) &&
            const DeepCollectionEquality()
                .equals(other._timezones, _timezones));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      flags,
      population,
      cca2,
      const DeepCollectionEquality().hash(_capital),
      region,
      subregion,
      area,
      const DeepCollectionEquality().hash(_timezones));

  /// Create a copy of CountryDetailsDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CountryDetailsDtoImplCopyWith<_$CountryDetailsDtoImpl> get copyWith =>
      __$$CountryDetailsDtoImplCopyWithImpl<_$CountryDetailsDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CountryDetailsDtoImplToJson(
      this,
    );
  }
}

abstract class _CountryDetailsDto implements CountryDetailsDto {
  const factory _CountryDetailsDto(
      {required final NameDto name,
      required final FlagsDto flags,
      required final int population,
      required final String cca2,
      final List<String> capital,
      final String region,
      final String subregion,
      final double? area,
      final List<String> timezones}) = _$CountryDetailsDtoImpl;

  factory _CountryDetailsDto.fromJson(Map<String, dynamic> json) =
      _$CountryDetailsDtoImpl.fromJson;

  @override
  NameDto get name;
  @override
  FlagsDto get flags;
  @override
  int get population;
  @override
  String get cca2;
  @override
  List<String> get capital;
  @override
  String get region;
  @override
  String get subregion;
  @override
  double? get area;
  @override
  List<String> get timezones;

  /// Create a copy of CountryDetailsDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CountryDetailsDtoImplCopyWith<_$CountryDetailsDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
