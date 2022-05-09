import 'dart:convert';

import 'package:chats/users/entity/user_entity.dart';
import 'package:firebase_database/firebase_database.dart';

class UserDatabase {
  final databaseRef = FirebaseDatabase.instance.reference();
  List<UserData> listOfUsers = [];

  createUserData(
      String email, String password, String userId, String username) {
    databaseRef.child('Users').child(userId).set({
      "email": email,
      "password": password,
      "userId": userId,
      "username": username,
    });
  }

  getAllUser() async {
    await databaseRef.child('Users').get().then((dataSnapshot) {
      Map<String, dynamic> values = jsonDecode(jsonEncode(dataSnapshot.value));
      listOfUsers.clear();
      values.forEach((key, values) {
        listOfUsers.add(UserData.fromJson(values));
      });
    });

    return listOfUsers;
  }
}