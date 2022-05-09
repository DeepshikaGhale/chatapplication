// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendData _$FriendDataFromJson(Map<String, dynamic> json) => FriendData(
      userId: json['userId'] as String? ?? '',
      username: json['username'] as String? ?? '',
      email: json['email'] as String? ?? '',
      isFriend: json['isFriend'] as bool? ?? false,
    );

Map<String, dynamic> _$FriendDataToJson(FriendData instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'username': instance.username,
      'email': instance.email,
      'isFriend': instance.isFriend,
    };
