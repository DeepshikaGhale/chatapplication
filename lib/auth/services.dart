import 'dart:convert';

import 'package:chats/auth/screen/login_screen.dart';
import 'package:chats/users/database/user_database.dart';
import 'package:chats/users/entity/user_entity.dart';
import 'package:chats/users/screen/contact_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentication {
  UserDatabase userDatabase = UserDatabase();

  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
  // String userId = '';

  //to register
  createUser(String email, String password, String username, BuildContext context,) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      print(email + password);


      print(credential.user!.uid);
      if (credential.user!.uid.isNotEmpty) {
        await userDatabase.createUserData(
            email, password, credential.user!.uid, username);
        
        // await userDatabase.createAllUserList(email);
      } else {
        print('id is null');
      }

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));

      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The password provided is too weak.')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The account already exists for that email.')));
      }
    } catch (e) {
      print(e);
      return;
    }
  }

  //to login
  authenticateUser(String email, String password, BuildContext context) async {

    final prefs = await SharedPreferences.getInstance();
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final userId = userCredential.user!.uid;

      if (userId.isNotEmpty) {
        final bearer = await FirebaseAuth.instance.currentUser!.getIdToken();

        prefs.setString('id_token', bearer.toString());       

        final snapshot = databaseReference.child('Users/$userId').get();

        await snapshot.then((snapshot) {
          final response = jsonDecode(jsonEncode(snapshot.value));
          final userDetails = UserData.fromJson(response);

      
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ContactScreen(
                        email: userDetails.email,
                        password: userDetails.password,
                        userId: userDetails.userId,
                        username: userDetails.username,
                      )));
        });
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('The user does not exist.')));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Wrong password provided for that user.')));
      }
    }
  }

  //to signout
  signout(BuildContext context) async {
    await FirebaseAuth.instance.signOut().then((value) => Navigator.of(context)
        .pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false));
  }
}
