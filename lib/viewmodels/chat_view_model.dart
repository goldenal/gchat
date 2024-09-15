import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
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
  bool hasInternet = true;
  bool loadingKey = false;
  bool localSender = false;

//returns currently logged in user id
  String? getSenderID() {
    return _auth.currentUser?.uid;
  }

//to check for internet access
  checkInternetAccess() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi ||
          result == ConnectivityResult.vpn) {
        hasInternet = true;
        notifyListeners();
      } else {
        hasInternet = false;
        notifyListeners();
      }
      // Got a new connectivity status!
    });
  }

//this is the function fetches all the users on the platform, it supply information to the UI
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

//this function fetches a particular chat ID
  Future<String> fetchID(String id2) async {
    String id1 = _auth.currentUser?.uid ?? "";
    List<dynamic> filteredItems = [];
    List<dynamic> chatIds = [];

    String selectedChat = "";

    try {
      chatIds = jsonDecode(localStorage.getItem('chatIds') ?? "");

      filteredItems = chatIds
          .where((item) => (item.contains(id1) && item.contains(id2)))
          .toList();
      if (filteredItems.length == 0) {
        return id1 +
            id2; //returns default id if no  id was found from the chatlist
      } else {
        return filteredItems[0];
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

//this fetchs all the  chatIDs on the platform
  Future<List> fetchChatIDKeys() async {
    loadingKey = true;
    notifyListeners();
    final ref = FirebaseDatabase.instance.ref();

    final snapshot = await ref.child('chat').get();
    log("F");
    final res = snapshot.value as Map<dynamic, dynamic>;
    localStorage.setItem('chatIds', jsonEncode(res.keys.toList()));
    loadingKey = false;
    notifyListeners();
    return res.keys.toList();
  }

  playSound(String sound) async {
    try {
      final player = AudioPlayer();
      await player.play(AssetSource('sounds/$sound.mp3'));
    } catch (e) {
      log(e.toString());
      // TODO
    }
  }

// this function is used for sending messages
  Future<bool> sendMesssage(String message, String senderID, String chatID,
      ScrollController ctrl) async {
    localSender = true;
    bool res = await cht.sendMessage(
        ChatModel(chatId: chatID, message: message, senderId: senderID));
    scrollList(ctrl);
    if (res) {
      await playSound("send");

      log("message sent");
    }

    return res;
  }

//for scrolling to the end of a list
  scrollList(ScrollController scrollController) {
    try {
      Timer(
          const Duration(milliseconds: 50),
          () => scrollController.animateTo(
                scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 1),
                curve: Curves.easeInOut,
              ));
      log("scrolled");
    } catch (e) {
      log(e.toString());
    }
  }
}
