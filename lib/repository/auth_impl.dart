import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:gchat/repository/auth_repository.dart';
import 'package:gchat/utils/toastimpl.dart';
import 'package:localstorage/localstorage.dart';

class AuthImpl implements AuthRepository {
  @override
  Future<bool> isLoggedIn() async {
    // Implement your login logic here
    return false;
  }

  @override
  Future<bool> login(String password, String email, context) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      showSimplePopup(context, e.code);
      return false;
    }
  }

  @override
  Future<bool> register(
      String name, String password, String email, context) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String id = _auth.currentUser!.uid;
      DatabaseReference ref = FirebaseDatabase.instance.ref("users/${id}");
      await ref.set({
        "name": name,
        "id": id,
      });

      return true;
    } on FirebaseAuthException catch (e) {
      showSimplePopup(context, e.code);
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<String> fetchUserName() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('users/${_auth.currentUser!.uid}').get();
    final snapshots = await ref.child('users').get();
    log("${snapshots.value}");

    final res = snapshot.value as Map<dynamic, dynamic>;
    localStorage.setItem('name', res['name']);
    return res['name'];
  }
}
