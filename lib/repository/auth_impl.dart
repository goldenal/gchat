import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:gchat/repository/auth_repository.dart';
import 'package:gchat/utils/toastimpl.dart';
import 'package:localstorage/localstorage.dart';

class AuthImpl implements AuthRepository {
//login function interacting with firebase auth
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

//register function interacting with firebase auth
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

//this fetches the name of the currently logged in user
  Future<String> fetchUserName() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('users/${_auth.currentUser!.uid}').get();

    final res = snapshot.value as Map<dynamic, dynamic>;
    localStorage.setItem('name', res['name']);
    return res['name'];
  }
}
