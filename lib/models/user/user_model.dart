import 'package:rider/models/branche/branche_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserModel {
  late int id;
  late List<String?> deviceToken;
  late String locale;
  late String name;
  late String phoneNumber;
  late String status;
  late DateTime createdAt;
  late DateTime updatedAt;

  UserModel({
    required this.id,
    required this.deviceToken,
    required this.locale,
    required this.name,
    required this.phoneNumber,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
