import 'package:chats/auth/screen/register_screen.dart';
import 'package:chats/chat/store.dart/chat_store.dart';
import 'package:chats/users/store/user_store.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';

import 'friends/store/friend_store.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseDatabase.instance.setPersistenceEnabled(true);
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => ChatStore()),
        Provider(create: (context) => UserListStore()),
        Provider(create: (context) => FriendStore())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.blue
        ),
        home: const RegisterScreen(),
      ),
    );
  }
}

