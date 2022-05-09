import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserData {
  @JsonKey(name: "userId", defaultValue: "", includeIfNull: true)
  final String userId;

  @JsonKey(name: "email", defaultValue: "", includeIfNull: true)
  final String email;

  @JsonKey(name: "password", defaultValue: "", includeIfNull: true)
  final String password;

  @JsonKey(name: "username", defaultValue: "", includeIfNull: true)
  final String username;

  // @JsonKey(name: "friends", includeIfNull: true)
  // final List<FriendData>? listOfFriends;

  UserData(
      {required this.userId,
      required this.email,
      required this.password,
      required this.username,
      // required this.listOfFriends
      });

  //to read the data from the snapshot
  factory UserData.fromJson(Map<String, dynamic> map) =>
      _$UserDataFromJson(map);

  //transform to json
  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
