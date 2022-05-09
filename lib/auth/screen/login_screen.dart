import 'package:chats/auth/request/google_sign_in.dart';
import 'package:chats/auth/services.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<LoginScreen> {
  final _fkey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _authentication = Authentication();

  double height = AppBar().preferredSize.height;
  double bottomHeight = kBottomNavigationBarHeight.toDouble();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _fkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'enter email',
                    border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter email address';
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                    labelText: 'Password',
                    hintText: 'enter password',
                    border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter email address';
                  }
                },
              ),
              ElevatedButton(
                child: const Text('Go >>'),
                onPressed: () {
                  if (_fkey.currentState!.validate()) {
                    _authentication.authenticateUser(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                        context);
                  }
                },
              ),
              IconButton(
                  onPressed: () async{
                    await FirebaseGoogleSignIn().signInWithGoogle(context: context);
                  },
                  icon: const Icon(Icons.ac_unit)),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Go to Register Screen'))
              
            ],
          ),
        ),
      ),
    );
  }
}
