import 'package:chats/users/screen/contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String token = "";
  bool autologin = false;
  @override
  void initState() {
    super.initState();
    route();
  }

  route() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const ContactScreen(userId: '', email: '', username: '', password: '',)));
  }

  autoLogin() async {
    final pref = await SharedPreferences.getInstance();

    token = pref.getString('id_token').toString();

    final prefUserId = pref.getString('user_Id').toString();
    final prefEmail = pref.getString('email').toString();
    final prefUsername = pref.getString('username').toString();
    final prefPassword = pref.getString('password').toString();
  

    await Future.delayed(const Duration(seconds: 2));
     Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ContactScreen(userId: prefUserId, email: prefEmail, username: prefUsername, password: prefPassword,)));
  }

  @override
  Widget build(BuildContext context) {
    
    return const Scaffold(
      body: Center(
        child: Text('Chat'),
      ),
    );
  }
}
