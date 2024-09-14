import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:gchat/models/chat/chatData.dart';
import 'package:gchat/models/chat/users.dart';
import 'package:gchat/repository/chat_repository.dart';

class ChatImpl implements ChatRepository {
  @override
  Future<Userdata> fetchUsers() async {
    List<MyUser> users = [];
    final ref = FirebaseDatabase.instance.ref();
    final snapshots = await ref.child('users').get();
   // ref.onValue.listen(onData)
    Map<dynamic, dynamic> values = snapshots.value as Map<dynamic, dynamic>;
    values.forEach((key, values) {
      log("<<${values}");
      users.add(MyUser(id: values["id"], name: values["name"]));
    });
    return Userdata(myUser: users);
  }

  // Future<ChatData> fetchChat()async{
  //   List<ChatModel> message = [];

  // }
}
