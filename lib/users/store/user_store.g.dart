// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserListStore on _UserListStore, Store {
  final _$allUsersListAtom = Atom(name: '_UserListStore.allUsersList');

  @override
  ObservableList<UserData> get allUsersList {
    _$allUsersListAtom.reportRead();
    return super.allUsersList;
  }

  @override
  set allUsersList(ObservableList<UserData> value) {
    _$allUsersListAtom.reportWrite(value, super.allUsersList, () {
      super.allUsersList = value;
    });
  }

  final _$getAllUserDataAsyncAction =
      AsyncAction('_UserListStore.getAllUserData');

  @override
  Future<dynamic> getAllUserData() {
    return _$getAllUserDataAsyncAction.run(() => super.getAllUserData());
  }

  @override
  String toString() {
    return '''
allUsersList: ${allUsersList}
    ''';
  }
}
