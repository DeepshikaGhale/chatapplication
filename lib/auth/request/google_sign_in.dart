import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseGoogleSignIn{
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  Future<User?> signInWithGoogle({required BuildContext context}) async{
    
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if(googleSignInAccount != null){
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken
      );
      try{
        final UserCredential userCredential = await auth.signInWithCredential(credential);
        user = userCredential.user;

        String username = userCredential.user!.displayName!;
        String email = userCredential.user!.email!;
        String uid = userCredential.user!.uid;
        print(username + " " + email + " " + uid);
      }on FirebaseAuthException catch(e){
        if(e.code == "account-exists-with-different-credential"){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text('The account already exists with a different credential.)',
            ),
          )
          );
        } else if(e.code == 'invalid-credential'){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text('Error occurred while accessing credentials. Try again.)',
            ),
          )
          );
        }
      } catch (e){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text(e.toString()),
          )
          );

      }

    }



      return user;
  }
}

// async{
// hp                      signInWithGoogle(model)
//                           .then((FirebaseUser user){
//                         model.clearAllModels();
//                         Navigator.of(context).pushNamedAndRemoveUntil
//                           (RouteName.Home, (Route<dynamic> route) => false
//                         );}
//                         ).catchError((e) => print(e));
//                       },
//                   ),