// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as int,
      deviceToken: (json['device_token'] as List<dynamic>)
          .map((e) => e as String?)
          .toList(),
      locale: json['locale'] as String,
      name: json['name'] as String,
      phoneNumber: json['phone_number'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'device_token': instance.deviceToken,
      'locale': instance.locale,
      'name': instance.name,
      'phone_number': instance.phoneNumber,
      'status': instance.status,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
