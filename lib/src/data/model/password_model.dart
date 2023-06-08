import 'package:freezed_annotation/freezed_annotation.dart';
part 'password_model.g.dart';
part 'password_model.freezed.dart';

@freezed
class PasswordModel with _$PasswordModel {
  const factory PasswordModel({
    String? email,
    String? current_password,
    String? password,
    String? password_confirmation,
  }) = _PasswordModel;
  factory PasswordModel.fromJson(Map<String, dynamic> json) => _$PasswordModelFromJson(json);
}
