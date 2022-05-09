import 'package:json_annotation/json_annotation.dart';

part 'friend.g.dart';

@JsonSerializable()
class FriendData {
  @JsonKey(name: "userId", defaultValue: "", includeIfNull: true)
  final String userId;

  @JsonKey(name: "username", defaultValue: "", includeIfNull: true)
  final String username;

  @JsonKey(name: "email", defaultValue: "", includeIfNull: true)
  final String email;

  @JsonKey(name: "isFriend", defaultValue: false, includeIfNull: true)
  final bool isFriend;
  
  FriendData({required this.userId, required this.username, required this.email, required this.isFriend});

  factory FriendData.fromJson(Map<String, dynamic> map) => _$FriendDataFromJson(map);

  Map<String, dynamic> toJson() => _$FriendDataToJson(this);
}
 