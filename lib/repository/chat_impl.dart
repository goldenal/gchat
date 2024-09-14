import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:gchat/models/chat/chatData.dart';
import 'package:gchat/models/chat/users.dart';
import 'package:gchat/repository/chat_repository.dart';

class ChatImpl implements ChatRepository {
  @override
  Future<Userdata> fetchUsers() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    List<MyUser> users = [];
    final ref = FirebaseDatabase.instance.ref();
    try {
      final snapshots = await ref.child('users').get();

      Map<dynamic, dynamic> values = snapshots.value as Map<dynamic, dynamic>;
      values.forEach((key, values) {
        log("<<${values}");
        if (_auth.currentUser!.uid != values["id"]) {
          users.add(MyUser(id: values["id"], name: values["name"]));
        }
      });

      return Userdata(myUser: users);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<bool> sendMessage(ChatModel data) async {
    try {
      DatabaseReference ref =
          FirebaseDatabase.instance.ref("chat/${data.chatId}");
      await ref.push().set(data.toJson()
        ..addAll({"timestamp": DateTime.now().millisecondsSinceEpoch}));
      return true;
    } catch (e) {
      log(e.toString());
      return false;
      // TODO
    }
  }
}
