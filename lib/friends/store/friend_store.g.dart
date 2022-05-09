// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FriendStore on _FriendStore, Store {
  final _$friendListAtom = Atom(name: '_FriendStore.friendList');

  @override
  ObservableList<FriendData> get friendList {
    _$friendListAtom.reportRead();
    return super.friendList;
  }

  @override
  set friendList(ObservableList<FriendData> value) {
    _$friendListAtom.reportWrite(value, super.friendList, () {
      super.friendList = value;
    });
  }

  final _$getAllFriendAsyncAction = AsyncAction('_FriendStore.getAllFriend');

  @override
  Future<dynamic> getAllFriend(String userId) {
    return _$getAllFriendAsyncAction.run(() => super.getAllFriend(userId));
  }

  final _$removeFriendAsyncAction = AsyncAction('_FriendStore.removeFriend');

  @override
  Future<dynamic> removeFriend(String userId, String friendUserId) {
    return _$removeFriendAsyncAction
        .run(() => super.removeFriend(userId, friendUserId));
  }

  @override
  String toString() {
    return '''
friendList: ${friendList}
    ''';
  }
}
