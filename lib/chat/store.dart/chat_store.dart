import 'package:chats/chat/database_service/chat_database.dart';
import 'package:chats/chat/entity/chat.dart';
import 'package:chats/chat/entity/friend.dart';
import 'package:mobx/mobx.dart';

part 'chat_store.g.dart';

class ChatStore = _ChatStore with _$ChatStore;

abstract class _ChatStore with Store {
  ChatDatabase chatDatabase = ChatDatabase();

  @observable
  ObservableList<ChatData> chatList = ObservableList();  

  //to save the chat
  @action
  Future saveChat(
      {required ChatData chatData,
      required String userId,
      required String friendUserId}) async {
    await chatDatabase.saveChat(
        chatData: chatData, userId: userId, friendUserId: friendUserId);
  }

  //to get all the chats
  @action
  Future getAllChats(String userId, String friendUserId) async {
    List<ChatData> firebaseChatData = [];

    await chatDatabase.getAllChatData(userId, friendUserId).then((value) {
      //add the data to list
      firebaseChatData.clear();
      firebaseChatData.addAll(value);

      //add the reversed list to the chat list
      chatList.clear();
      chatList.addAll(firebaseChatData.reversed) ;
      return chatList;
    });
  }
}
