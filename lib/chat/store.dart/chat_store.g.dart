// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatStore on _ChatStore, Store {
  final _$chatListAtom = Atom(name: '_ChatStore.chatList');

  @override
  ObservableList<ChatData> get chatList {
    _$chatListAtom.reportRead();
    return super.chatList;
  }

  @override
  set chatList(ObservableList<ChatData> value) {
    _$chatListAtom.reportWrite(value, super.chatList, () {
      super.chatList = value;
    });
  }

  final _$saveChatAsyncAction = AsyncAction('_ChatStore.saveChat');

  @override
  Future<dynamic> saveChat(
      {required ChatData chatData,
      required String userId,
      required String friendUserId}) {
    return _$saveChatAsyncAction.run(() => super.saveChat(
        chatData: chatData, userId: userId, friendUserId: friendUserId));
  }

  final _$getAllChatsAsyncAction = AsyncAction('_ChatStore.getAllChats');

  @override
  Future<dynamic> getAllChats(String userId, String friendUserId) {
    return _$getAllChatsAsyncAction
        .run(() => super.getAllChats(userId, friendUserId));
  }

  @override
  String toString() {
    return '''
chatList: ${chatList}
    ''';
  }
}
