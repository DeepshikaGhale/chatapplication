import 'package:chats/auth/services.dart';
import 'package:chats/friends/database/friend_database.dart';
import 'package:chats/friends/store/friend_store.dart';
import 'package:chats/users/database/user_database.dart';
import 'package:chats/chat/screen/chat_screen.dart';
import 'package:chats/users/store/user_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen(
      {Key? key,
      required this.email,
      required this.password,
      required this.userId,
      required this.username
      })
      : super(key: key);

  final String email;
  final String password;
  final String userId;
  final String username;

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  Authentication authentication = Authentication();
  UserDatabase userDatabase = UserDatabase();
  FriendDatabase friendDatabase = FriendDatabase();

  UserListStore userListStore = UserListStore();
  FriendStore friendStore = FriendStore();

  // bool isFriend = false;

  @override
  void didChangeDependencies() async {
    userListStore = Provider.of<UserListStore>(context, listen: false);
    friendStore = Provider.of<FriendStore>(context, listen: false);
    await userListStore.getAllUserData();
    await friendStore.getAllFriend(widget.userId);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Chat'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Text("This is chat screen"),
              Text('email : ${widget.email}'),
              Text('password : ${widget.password}'),
              TextButton(
                  onPressed: () {
                    authentication.signout(context);
                  },
                  child: const Text('Logout')),
              const Text('Users'),
              userList(),
              const Text('Friends'),
              friendList()
            ],
          ),
        ));
  }

  userList() {
    return Observer(builder: (context) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: userListStore.allUsersList.length,
          itemBuilder: (context, index) {
            if (userListStore.allUsersList.isNotEmpty) {
              return userListItem(userListStore.allUsersList[index].username,
                  userListStore.allUsersList[index].userId);
            }
            return const Text('No Users Found');
          });
    });
  }

  Widget userListItem(String username, String userId) {
    return ListTile(
      leading: (userId == widget.userId)
          ? Text(
              username + "(You)",
              style: const TextStyle(color: Colors.grey),
            )
          : Text(username),
      trailing: (userId == widget.userId)
          ? const SizedBox.shrink()
          : 
          IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () async{
                    await friendDatabase.createFriendList(
                      context: context, 
                      userId: widget.userId,
                      friendUserId: userId,
                      friendUsername: username,
                      ownUsername: widget.username
                        );
                    await friendStore.getAllFriend(widget.userId);
                  },
          ),
    );
  }

  friendList() {
    return Observer(
      builder: (context) {
      return ListView.builder(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: friendStore.friendList.length,
          itemBuilder: (context, index) {
            if (friendStore.friendList.isEmpty || friendStore.friendList == null){
              return const Text('No Friends');
            }
            return friendListItem(friendStore.friendList[index].username,
                  friendStore.friendList[index].userId);
          });
    });
  }

  Widget friendListItem(String username, String userId) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => 
        ChatScreen(userId: widget.userId, username: widget.username, friendUserId: userId, friendusername: username,)));
      
      },
      child: ListTile(
        leading: Text(username),
        trailing: IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () async{
            await friendStore.removeFriend(widget.userId, userId);
            await friendStore.getAllFriend(widget.userId);
          },
        ),
      ),
    );
  }
}
