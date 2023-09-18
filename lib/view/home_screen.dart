import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_authentication/view/login_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key, required this.auth});
  FirebaseAuth auth;

  Future<void> logout() async {
    await GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome ${auth.currentUser!.displayName}'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              auth.currentUser!.photoURL.toString(),
            ),
            radius: 50,
          ),
          ListTile(
            title: Text(auth.currentUser!.displayName.toString()),
            subtitle: Text(auth.currentUser!.email.toString()),
            trailing: IconButton(
              onPressed: () async {
                await logout();
                await Get.offAll(
                  LoginScreen(),
                  transition: Transition.fade,
                );
              },
              icon: const Icon(
                Icons.logout,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
