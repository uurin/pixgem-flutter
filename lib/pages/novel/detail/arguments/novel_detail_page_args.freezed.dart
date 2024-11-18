// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'novel_detail_page_args.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NovelDetailPageArguments {
  String get worksId => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  CommonNovel? get detail => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NovelDetailPageArgumentsCopyWith<NovelDetailPageArguments> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NovelDetailPageArgumentsCopyWith<$Res> {
  factory $NovelDetailPageArgumentsCopyWith(NovelDetailPageArguments value,
          $Res Function(NovelDetailPageArguments) then) =
      _$NovelDetailPageArgumentsCopyWithImpl<$Res, NovelDetailPageArguments>;
  @useResult
  $Res call({String worksId, String? title, CommonNovel? detail});
}

/// @nodoc
class _$NovelDetailPageArgumentsCopyWithImpl<$Res,
        $Val extends NovelDetailPageArguments>
    implements $NovelDetailPageArgumentsCopyWith<$Res> {
  _$NovelDetailPageArgumentsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? worksId = null,
    Object? title = freezed,
    Object? detail = freezed,
  }) {
    return _then(_value.copyWith(
      worksId: null == worksId
          ? _value.worksId
          : worksId // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      detail: freezed == detail
          ? _value.detail
          : detail // ignore: cast_nullable_to_non_nullable
              as CommonNovel?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NovelDetailPageArgumentsImplCopyWith<$Res>
    implements $NovelDetailPageArgumentsCopyWith<$Res> {
  factory _$$NovelDetailPageArgumentsImplCopyWith(
          _$NovelDetailPageArgumentsImpl value,
          $Res Function(_$NovelDetailPageArgumentsImpl) then) =
      __$$NovelDetailPageArgumentsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String worksId, String? title, CommonNovel? detail});
}

/// @nodoc
class __$$NovelDetailPageArgumentsImplCopyWithImpl<$Res>
    extends _$NovelDetailPageArgumentsCopyWithImpl<$Res,
        _$NovelDetailPageArgumentsImpl>
    implements _$$NovelDetailPageArgumentsImplCopyWith<$Res> {
  __$$NovelDetailPageArgumentsImplCopyWithImpl(
      _$NovelDetailPageArgumentsImpl _value,
      $Res Function(_$NovelDetailPageArgumentsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? worksId = null,
    Object? title = freezed,
    Object? detail = freezed,
  }) {
    return _then(_$NovelDetailPageArgumentsImpl(
      worksId: null == worksId
          ? _value.worksId
          : worksId // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      detail: freezed == detail
          ? _value.detail
          : detail // ignore: cast_nullable_to_non_nullable
              as CommonNovel?,
    ));
  }
}

/// @nodoc

class _$NovelDetailPageArgumentsImpl implements _NovelDetailPageArguments {
  const _$NovelDetailPageArgumentsImpl(
      {required this.worksId, this.title, this.detail});

  @override
  final String worksId;
  @override
  final String? title;
  @override
  final CommonNovel? detail;

  @override
  String toString() {
    return 'NovelDetailPageArguments(worksId: $worksId, title: $title, detail: $detail)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NovelDetailPageArgumentsImpl &&
            (identical(other.worksId, worksId) || other.worksId == worksId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.detail, detail) || other.detail == detail));
  }

  @override
  int get hashCode => Object.hash(runtimeType, worksId, title, detail);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NovelDetailPageArgumentsImplCopyWith<_$NovelDetailPageArgumentsImpl>
      get copyWith => __$$NovelDetailPageArgumentsImplCopyWithImpl<
          _$NovelDetailPageArgumentsImpl>(this, _$identity);
}

abstract class _NovelDetailPageArguments implements NovelDetailPageArguments {
  const factory _NovelDetailPageArguments(
      {required final String worksId,
      final String? title,
      final CommonNovel? detail}) = _$NovelDetailPageArgumentsImpl;

  @override
  String get worksId;
  @override
  String? get title;
  @override
  CommonNovel? get detail;
  @override
  @JsonKey(ignore: true)
  _$$NovelDetailPageArgumentsImplCopyWith<_$NovelDetailPageArgumentsImpl>
      get copyWith => throw _privateConstructorUsedError;
}