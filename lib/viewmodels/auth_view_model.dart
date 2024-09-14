import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gchat/repository/auth_impl.dart';
import 'package:gchat/views/bottombar.dart';
import 'package:localstorage/localstorage.dart';

class AuthViewModel extends ChangeNotifier {
  AuthImpl auth = AuthImpl();
  bool isLoading = false;
  bool isVisible = true;

  changeVisibility() {
    isVisible = !isVisible;
    notifyListeners();
  }


  register(name, password, email, context) async {
    isLoading = true;
    notifyListeners();
    try {
      log("F");
      bool res = await auth.register(name, password, email, context);
      isLoading = false;
      notifyListeners();
      if (res) {
        localStorage.setItem('loggedin', "true");
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomBar(),
          ),
          (route) => false,
        );
      }
    } catch (e) {
      log(e.toString());
    }
  }

  login(password, email, context) async {
    isLoading = true;
    notifyListeners();
    bool res = await auth.login(password, email, context);
    isLoading = false;
    notifyListeners();
    if (res) {
      localStorage.setItem('loggedin', "true");
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const BottomBar(),
        ),
        (route) => false,
      );
    }
  }
}
