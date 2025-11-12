// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'country_summary_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CountrySummaryDto _$CountrySummaryDtoFromJson(Map<String, dynamic> json) {
  return _CountrySummaryDto.fromJson(json);
}

/// @nodoc
mixin _$CountrySummaryDto {
  NameDto get name => throw _privateConstructorUsedError;
  FlagsDto get flags => throw _privateConstructorUsedError;
  int get population => throw _privateConstructorUsedError;
  String get cca2 => throw _privateConstructorUsedError;

  /// Serializes this CountrySummaryDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CountrySummaryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CountrySummaryDtoCopyWith<CountrySummaryDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CountrySummaryDtoCopyWith<$Res> {
  factory $CountrySummaryDtoCopyWith(
          CountrySummaryDto value, $Res Function(CountrySummaryDto) then) =
      _$CountrySummaryDtoCopyWithImpl<$Res, CountrySummaryDto>;
  @useResult
  $Res call({NameDto name, FlagsDto flags, int population, String cca2});

  $NameDtoCopyWith<$Res> get name;
  $FlagsDtoCopyWith<$Res> get flags;
}

/// @nodoc
class _$CountrySummaryDtoCopyWithImpl<$Res, $Val extends CountrySummaryDto>
    implements $CountrySummaryDtoCopyWith<$Res> {
  _$CountrySummaryDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CountrySummaryDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? flags = null,
    Object? population = null,
    Object? cca2 = null,
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
    ) as $Val);
  }

  /// Create a copy of CountrySummaryDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NameDtoCopyWith<$Res> get name {
    return $NameDtoCopyWith<$Res>(_value.name, (value) {
      return _then(_value.copyWith(name: value) as $Val);
    });
  }

  /// Create a copy of CountrySummaryDto
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
abstract class _$$CountrySummaryDtoImplCopyWith<$Res>
    implements $CountrySummaryDtoCopyWith<$Res> {
  factory _$$CountrySummaryDtoImplCopyWith(_$CountrySummaryDtoImpl value,
          $Res Function(_$CountrySummaryDtoImpl) then) =
      __$$CountrySummaryDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({NameDto name, FlagsDto flags, int population, String cca2});

  @override
  $NameDtoCopyWith<$Res> get name;
  @override
  $FlagsDtoCopyWith<$Res> get flags;
}

/// @nodoc
class __$$CountrySummaryDtoImplCopyWithImpl<$Res>
    extends _$CountrySummaryDtoCopyWithImpl<$Res, _$CountrySummaryDtoImpl>
    implements _$$CountrySummaryDtoImplCopyWith<$Res> {
  __$$CountrySummaryDtoImplCopyWithImpl(_$CountrySummaryDtoImpl _value,
      $Res Function(_$CountrySummaryDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of CountrySummaryDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? flags = null,
    Object? population = null,
    Object? cca2 = null,
  }) {
    return _then(_$CountrySummaryDtoImpl(
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CountrySummaryDtoImpl implements _CountrySummaryDto {
  const _$CountrySummaryDtoImpl(
      {required this.name,
      required this.flags,
      required this.population,
      required this.cca2});

  factory _$CountrySummaryDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CountrySummaryDtoImplFromJson(json);

  @override
  final NameDto name;
  @override
  final FlagsDto flags;
  @override
  final int population;
  @override
  final String cca2;

  @override
  String toString() {
    return 'CountrySummaryDto(name: $name, flags: $flags, population: $population, cca2: $cca2)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CountrySummaryDtoImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.flags, flags) || other.flags == flags) &&
            (identical(other.population, population) ||
                other.population == population) &&
            (identical(other.cca2, cca2) || other.cca2 == cca2));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, flags, population, cca2);

  /// Create a copy of CountrySummaryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CountrySummaryDtoImplCopyWith<_$CountrySummaryDtoImpl> get copyWith =>
      __$$CountrySummaryDtoImplCopyWithImpl<_$CountrySummaryDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CountrySummaryDtoImplToJson(
      this,
    );
  }
}

abstract class _CountrySummaryDto implements CountrySummaryDto {
  const factory _CountrySummaryDto(
      {required final NameDto name,
      required final FlagsDto flags,
      required final int population,
      required final String cca2}) = _$CountrySummaryDtoImpl;

  factory _CountrySummaryDto.fromJson(Map<String, dynamic> json) =
      _$CountrySummaryDtoImpl.fromJson;

  @override
  NameDto get name;
  @override
  FlagsDto get flags;
  @override
  int get population;
  @override
  String get cca2;

  /// Create a copy of CountrySummaryDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CountrySummaryDtoImplCopyWith<_$CountrySummaryDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NameDto _$NameDtoFromJson(Map<String, dynamic> json) {
  return _NameDto.fromJson(json);
}

/// @nodoc
mixin _$NameDto {
  String get common => throw _privateConstructorUsedError;

  /// Serializes this NameDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NameDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NameDtoCopyWith<NameDto> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NameDtoCopyWith<$Res> {
  factory $NameDtoCopyWith(NameDto value, $Res Function(NameDto) then) =
      _$NameDtoCopyWithImpl<$Res, NameDto>;
  @useResult
  $Res call({String common});
}

/// @nodoc
class _$NameDtoCopyWithImpl<$Res, $Val extends NameDto>
    implements $NameDtoCopyWith<$Res> {
  _$NameDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NameDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? common = null,
  }) {
    return _then(_value.copyWith(
      common: null == common
          ? _value.common
          : common // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NameDtoImplCopyWith<$Res> implements $NameDtoCopyWith<$Res> {
  factory _$$NameDtoImplCopyWith(
          _$NameDtoImpl value, $Res Function(_$NameDtoImpl) then) =
      __$$NameDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String common});
}

/// @nodoc
class __$$NameDtoImplCopyWithImpl<$Res>
    extends _$NameDtoCopyWithImpl<$Res, _$NameDtoImpl>
    implements _$$NameDtoImplCopyWith<$Res> {
  __$$NameDtoImplCopyWithImpl(
      _$NameDtoImpl _value, $Res Function(_$NameDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of NameDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? common = null,
  }) {
    return _then(_$NameDtoImpl(
      common: null == common
          ? _value.common
          : common // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NameDtoImpl implements _NameDto {
  const _$NameDtoImpl({required this.common});

  factory _$NameDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$NameDtoImplFromJson(json);

  @override
  final String common;

  @override
  String toString() {
    return 'NameDto(common: $common)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NameDtoImpl &&
            (identical(other.common, common) || other.common == common));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, common);

  /// Create a copy of NameDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NameDtoImplCopyWith<_$NameDtoImpl> get copyWith =>
      __$$NameDtoImplCopyWithImpl<_$NameDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NameDtoImplToJson(
      this,
    );
  }
}

abstract class _NameDto implements NameDto {
  const factory _NameDto({required final String common}) = _$NameDtoImpl;

  factory _NameDto.fromJson(Map<String, dynamic> json) = _$NameDtoImpl.fromJson;

  @override
  String get common;

  /// Create a copy of NameDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NameDtoImplCopyWith<_$NameDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FlagsDto _$FlagsDtoFromJson(Map<String, dynamic> json) {
  return _FlagsDto.fromJson(json);
}

/// @nodoc
mixin _$FlagsDto {
  String get png => throw _privateConstructorUsedError;
  String get svg => throw _privateConstructorUsedError;

  /// Serializes this FlagsDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FlagsDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FlagsDtoCopyWith<FlagsDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FlagsDtoCopyWith<$Res> {
  factory $FlagsDtoCopyWith(FlagsDto value, $Res Function(FlagsDto) then) =
      _$FlagsDtoCopyWithImpl<$Res, FlagsDto>;
  @useResult
  $Res call({String png, String svg});
}

/// @nodoc
class _$FlagsDtoCopyWithImpl<$Res, $Val extends FlagsDto>
    implements $FlagsDtoCopyWith<$Res> {
  _$FlagsDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FlagsDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? png = null,
    Object? svg = null,
  }) {
    return _then(_value.copyWith(
      png: null == png
          ? _value.png
          : png // ignore: cast_nullable_to_non_nullable
              as String,
      svg: null == svg
          ? _value.svg
          : svg // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FlagsDtoImplCopyWith<$Res>
    implements $FlagsDtoCopyWith<$Res> {
  factory _$$FlagsDtoImplCopyWith(
          _$FlagsDtoImpl value, $Res Function(_$FlagsDtoImpl) then) =
      __$$FlagsDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String png, String svg});
}

/// @nodoc
class __$$FlagsDtoImplCopyWithImpl<$Res>
    extends _$FlagsDtoCopyWithImpl<$Res, _$FlagsDtoImpl>
    implements _$$FlagsDtoImplCopyWith<$Res> {
  __$$FlagsDtoImplCopyWithImpl(
      _$FlagsDtoImpl _value, $Res Function(_$FlagsDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of FlagsDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? png = null,
    Object? svg = null,
  }) {
    return _then(_$FlagsDtoImpl(
      png: null == png
          ? _value.png
          : png // ignore: cast_nullable_to_non_nullable
              as String,
      svg: null == svg
          ? _value.svg
          : svg // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FlagsDtoImpl implements _FlagsDto {
  const _$FlagsDtoImpl({required this.png, required this.svg});

  factory _$FlagsDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$FlagsDtoImplFromJson(json);

  @override
  final String png;
  @override
  final String svg;

  @override
  String toString() {
    return 'FlagsDto(png: $png, svg: $svg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FlagsDtoImpl &&
            (identical(other.png, png) || other.png == png) &&
            (identical(other.svg, svg) || other.svg == svg));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, png, svg);

  /// Create a copy of FlagsDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FlagsDtoImplCopyWith<_$FlagsDtoImpl> get copyWith =>
      __$$FlagsDtoImplCopyWithImpl<_$FlagsDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FlagsDtoImplToJson(
      this,
    );
  }
}

abstract class _FlagsDto implements FlagsDto {
  const factory _FlagsDto(
      {required final String png, required final String svg}) = _$FlagsDtoImpl;

  factory _FlagsDto.fromJson(Map<String, dynamic> json) =
      _$FlagsDtoImpl.fromJson;

  @override
  String get png;
  @override
  String get svg;

  /// Create a copy of FlagsDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FlagsDtoImplCopyWith<_$FlagsDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
