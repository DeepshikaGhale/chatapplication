// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatData _$ChatDataFromJson(Map<String, dynamic> json) => ChatData(
      userId: json['userId'] as String? ?? '',
      username: json['username'] as String? ?? '',
      message: json['message'] as String? ?? '',
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$ChatDataToJson(ChatData instance) => <String, dynamic>{
      'userId': instance.userId,
      'username': instance.username,
      'message': instance.message,
      'date': instance.date.toIso8601String(),
    };
