import 'package:chats/chat/entity/friend.dart';
import 'package:chats/friends/database/friend_database.dart';
import 'package:mobx/mobx.dart';

part 'friend_store.g.dart';

class FriendStore = _FriendStore with _$FriendStore;

abstract class _FriendStore with Store {
  FriendDatabase friendDatabase = FriendDatabase();

  @observable
  ObservableList<FriendData> friendList = ObservableList();

  @action
  Future getAllFriend(String userId) async{
    await friendDatabase.getAllfriendList(userId).then((value) {
      friendList.clear();
      friendList.addAll(value);
    } );
  }

  @action
  Future removeFriend(String userId, String friendUserId) async{
    await friendDatabase.removeFriend(userId, friendUserId);
  }
}
