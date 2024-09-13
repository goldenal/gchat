import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gchat/repository/auth_impl.dart';
import 'package:gchat/views/auth/login.dart';
import 'package:localstorage/localstorage.dart';

class ProfileModel extends ChangeNotifier {
  AuthImpl auth = AuthImpl();
  bool loading = false;
  String userName = '';
  final FirebaseAuth authenticate = FirebaseAuth.instance;

  fetchUserName() async {
    if (localStorage.getItem('name') != null) {
      userName = localStorage.getItem('name')!;
      userName = await auth.fetchUserName();
      localStorage.setItem('name', userName);
    } else {
      loading = true;
      userName = await auth.fetchUserName();
      loading = false;
    }
    localStorage.setItem('name', userName);
  }

  String processInitials() {
    final words = userName.split(' ');

    if (words.length == 1) {
      return userName.substring(0, 2).toUpperCase();
    } else {
      return words.map((word) => word[0].toUpperCase()).join('');
    }
  }

  signOut(context) {
    authenticate.signOut();
    localStorage.setItem('loggedin', "false");
    localStorage.removeItem('name');

    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }
}
