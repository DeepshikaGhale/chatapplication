import 'dart:convert';

import 'package:chats/chat/entity/chat.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatDatabase {
  final databaseRef = FirebaseDatabase.instance.reference();
  String child = '';
  final List<ChatData> chatDataList = [];

  //to create and save chats
  Future saveChat(
      {required ChatData chatData,
      required String userId,
      required String friendUserId}) async {

    //combine userId and friendUserId
    String key = userId.toLowerCase() + friendUserId.toLowerCase();

    orderString(key);

    String chatNode = child;
    final chatRef = FirebaseDatabase.instance
        .reference()
        .child('Chats')
        .child(chatNode)
        .push();

    await chatRef.set(chatData.toJson());

    chatRef.onChildAdded.listen((event) {
      getAllChatData(userId, friendUserId);
    });
  }

  //to generate the key for chat between two different users
  orderString(String key) {
    List<String> split = key.split(" ");

    var newData = split.map((e) {
      List<String> splited = e.split('');
      splited.sort((a, b) => a.toUpperCase().compareTo(b.toUpperCase()));
      return splited.join('');
    });

    child = newData.join(' ').toString();
  }

  //to get all the chat data
  Future<List<ChatData>> getAllChatData(String userId, String friendUserId) async {
    String key = userId.toLowerCase() + friendUserId.toLowerCase();

    orderString(key);

    String node = child;

    await databaseRef
        .child('Chats')
        .child(node)
        .orderByChild("date")
        .get()
        .then((dataSnapshot) {
      if (dataSnapshot.exists) {
        chatDataList.clear();
        Map<String, dynamic> values =
            jsonDecode(jsonEncode(dataSnapshot.value));

        values.forEach((key, values) {
          final chatDetails = ChatData.fromJson(values);
          chatDataList.add(chatDetails);
        });
        //sorting the list according to the date
        chatDataList.sort((a,b)=> a.date.compareTo(b.date)); 

        return chatDataList;
      } else {
        return chatDataList;
      }
    });

    return chatDataList;
  }
}
