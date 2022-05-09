import 'package:chats/users/database/user_database.dart';
import 'package:chats/users/entity/user_entity.dart';
import 'package:mobx/mobx.dart';

part 'user_store.g.dart';

class UserListStore = _UserListStore with _$UserListStore;

abstract class _UserListStore with Store {

  UserDatabase userDatabase = UserDatabase();

  @observable
  ObservableList<UserData> allUsersList = ObservableList();

  @action
  Future getAllUserData() async {
    await await userDatabase.getAllUser().then((value) {
      allUsersList.clear();
      allUsersList.addAll(value);

      return allUsersList;
    });

    return allUsersList;
  }
}