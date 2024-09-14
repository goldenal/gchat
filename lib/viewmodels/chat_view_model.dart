import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gchat/models/chat/chatData.dart';
import 'package:gchat/models/chat/users.dart';
import 'package:gchat/repository/chat_impl.dart';
import 'package:localstorage/localstorage.dart';

class ChatViewModel extends ChangeNotifier {
  bool loading = true;
  Userdata userdata = Userdata();
  ChatImpl cht = ChatImpl();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  ChatData chats = ChatData();
  final refInstance = FirebaseDatabase.instance;

  String? getSenderID() {
    return _auth.currentUser?.uid;
  }

  // getChatID(String otherUserID) async {
  //   return "${_auth.currentUser?.uid}$otherUserID";
  // }

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

  Future<String> fetchID(String id2) async {
    String id1 = _auth.currentUser?.uid ?? "";
    List<dynamic> filteredItems = [];
    String selectedChat = "";

    final ref = FirebaseDatabase.instance.ref();

    final snapshot = await ref.child('chat').get();
    final res = snapshot.value as Map<dynamic, dynamic>;
    List<dynamic> chatIds = res.keys.toList();
    filteredItems = chatIds
        .where((item) => (item.contains(id1) && item.contains(id2)))
        .toList();
    if (filteredItems.length == 0) {
      return id1 + id2;
    } else {
      return filteredItems[0];
    }
  }

  Future<bool> sendMesssage(String message, String senderID, String chatID,
      ScrollController ctrl) async {
    bool res = await cht.sendMessage(
        ChatModel(chatId: chatID, message: message, senderId: senderID));
    scrollList(ctrl);
    log("message sent");
    return res;
  }

  scrollList(ScrollController scrollController) {
    Timer(
        const Duration(milliseconds: 50),
        () => scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 1),
              curve: Curves.easeInOut,
            ));

    log("F");
  }
}
