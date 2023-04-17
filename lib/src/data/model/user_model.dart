import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:outfit/src/data/view_model/auth_view_model.dart';
part 'user_model.g.dart';
part 'user_model.freezed.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    @JsonKey(includeIfNull: false) String? userid,
    @JsonKey(includeIfNull: false) String? name,
    @JsonKey(includeIfNull: false) String? first_name,
    @JsonKey(includeIfNull: false) String? last_name,
    @JsonKey(includeIfNull: false) String? type,
    @JsonKey(includeIfNull: false) String? email,
    @JsonKey(includeIfNull: false) String? password,
    @JsonKey(includeIfNull: false) AuthProvider? authProvider,
  }) = _UserModel;
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}
