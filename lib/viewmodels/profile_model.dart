import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gchat/repository/auth_impl.dart';
import 'package:gchat/views/auth/login.dart';
import 'package:localstorage/localstorage.dart';

class ProfileModel extends ChangeNotifier {
  AuthImpl auth = AuthImpl();
  bool loading = true;
  String userName = '';
  final FirebaseAuth authenticate = FirebaseAuth.instance;

  fetchUserName() async {
    if (localStorage.getItem('name') != null) {
      loading = false;
      userName = localStorage.getItem('name')!;
      notifyListeners();
      userName = await auth.fetchUserName();

      localStorage.setItem('name', userName);
      notifyListeners();
    } else {
      loading = true;
      notifyListeners();
      userName = await auth.fetchUserName();
      loading = false;
      localStorage.setItem('name', userName);
      notifyListeners();
    }
  }

  String processInitials(name) {
    List<String> words = name.split(' ');

    if (words.length > 1) {
      // If there are two or more words, return the first character of the first two words
      return words[0][0] + words[1][0];
    } else if (words.length == 1 && words[0].isNotEmpty) {
      // If there's only one word, return the first character twice
      return words[0][0] + words[0][0];
    }

    return '';
  }

  signOut(context) {
    authenticate.signOut();
    localStorage.setItem('loggedin', "false");
    localStorage.removeItem('name');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => Login(),
      ),
      (route) => false,
    );
  }
}
