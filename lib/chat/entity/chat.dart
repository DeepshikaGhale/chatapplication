import 'package:json_annotation/json_annotation.dart';

part 'chat.g.dart';

@JsonSerializable()
class ChatData {
  @JsonKey(name: "userId", defaultValue: "", includeIfNull: true)
  final String userId;

  @JsonKey(name: "username", defaultValue: "", includeIfNull: true)
  final String username;

  @JsonKey(name: "message", defaultValue: "", includeIfNull: true)
  final String message;

  @JsonKey(name: "date", includeIfNull: true)
  final DateTime date;

  ChatData(
      {required this.userId,
      required this.username,
      required this.message,
      required this.date});

  factory ChatData.fromJson(Map<String, dynamic> json) => _$ChatDataFromJson(json);
  
  Map<String, dynamic> toJson() => _$ChatDataToJson(this);
}
