import 'dart:convert';

import 'package:chats/chat/entity/friend.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FriendDatabase {
  final databaseRef = FirebaseDatabase.instance.reference();
  List<FriendData> listOfFriends = [];

  createFriendList(
      {required String userId,
      required String friendUserId,
      required String friendUsername,
      required String ownUsername,
      required BuildContext context}) async {
    var friendList =
        databaseRef.child('Users').child(userId).child("friends").push();

    var otherFriendList =
        databaseRef.child('Users').child(friendUserId).child("friends").push();

    //check if the id already exists or not
    await databaseRef
        .child('Users')
        .child('$userId/friends')
        .get()
        .then((snapshot) {
      //check if the friend list already exists
      if (snapshot.exists) {
        Map<String, dynamic> values = jsonDecode(jsonEncode(snapshot.value));
        listOfFriends.clear();
        values.forEach((key, values) {
          listOfFriends.add(FriendData.fromJson(values));
        });

        var length = listOfFriends.length;

        for (var i = 0; i < length; i++) {
          if (listOfFriends[i].userId != friendUserId || listOfFriends[i].isFriend == false) {
            friendList
                .set({"userId": friendUserId, "username": friendUsername, "isFriend" : true});
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('The user is already your friend.')));
            return;
          }

          friendList.onChildAdded.listen((event) {
            // ScaffoldMessenger.of(context)
            //     .showSnackBar(const SnackBar(content: Text('Added')));
            print('added');
          });
        }
      }

      //if the friendlist does not exists
      else {
        friendList.set({"userId": friendUserId, "username": friendUsername, "isFriend" : true});
        friendList.onChildAdded.listen((event) {
          // ScaffoldMessenger.of(context)
          //     .showSnackBar(const SnackBar(content: Text('Added')));
          print('added');
        });
      }
    });

    //when friend is removed
    // friendList.onChildRemoved.listen((event) {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(const SnackBar(content: Text('Removed')));
    // });

    //to add the user to the friend's list
    await otherFriendList.set({"userId": userId, "username": ownUsername, "isFriend" : true});
    // otherFriendList.onChildAdded.listen((event) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(content: Text("Added on your friend's list.")));
    // });
  }

  Future<List<FriendData>> getAllfriendList(String userId) async {
    await databaseRef
        .child('Users')
        .child('$userId/friends')
        .get()
        .then((dataSnapshot) {
      listOfFriends.clear();
      if (dataSnapshot.exists) {
        Map<String, dynamic> values =
            jsonDecode(jsonEncode(dataSnapshot.value));
        values.forEach((key, values) {
          listOfFriends.add(FriendData.fromJson(values));
        });
      } else {
        return listOfFriends;
      }
    });

    return listOfFriends;
  }

  Future removeFriend(String userId, String friendUserId) async {
    await databaseRef
        .child('Users')
        .child('$userId/friends')
        .get()
        .then((dataSnapshot) {
      if (dataSnapshot.exists) {
        Map<String, dynamic> values =
            jsonDecode(jsonEncode(dataSnapshot.value));

        values.forEach((key, values) {
          var cvalue = FriendData.fromJson(values);
          var index = key;

          if (cvalue.userId == friendUserId) {
            FirebaseDatabase.instance
                .reference()
                .child('Users')
                .child('$userId/friends/$index')
                .remove();
          } else {
            print('does not exists');
          }
        });
      }
    });

    await getAllfriendList(userId);
    
}
}