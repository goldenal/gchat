import 'dart:convert';
import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gchat/models/chat/users.dart';
import 'package:gchat/repository/chat_impl.dart';
import 'package:localstorage/localstorage.dart';

class ChatViewModel extends ChangeNotifier {
  bool loading = true;
  Userdata userdata = Userdata();
  ChatImpl cht = ChatImpl();

  loadUsers() async {
    log('<<>>${localStorage.getItem('users')}');
    if (localStorage.getItem('users') != null) {
      loading = false;

      final Map<String, dynamic> json =
          jsonDecode(localStorage.getItem('users')!);
      userdata = Userdata.fromJson(json);
      notifyListeners();

      userdata = await cht.fetchUsers();
      localStorage.setItem('users', jsonEncode(userdata));
      notifyListeners();
    } else {
      loading = true;
      notifyListeners();
      userdata = await cht.fetchUsers();
      localStorage.setItem('users', jsonEncode(userdata));
      loading = false;
      notifyListeners();
    }
  }

  fetchChats(String chatId)async{
    final ref = FirebaseDatabase.instance.ref();
    final snapshots = await ref.child(chatId).get();
   // ref.onValue.listen(onData)
  }
}
