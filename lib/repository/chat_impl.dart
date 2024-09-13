import 'package:firebase_database/firebase_database.dart';
import 'package:gchat/models/chat/users.dart';
import 'package:gchat/repository/chat_repository.dart';

class ChatImpl implements ChatRepository {
  @override
  Future<List<MyUser>> fetchUsers() async {
    List<MyUser> users = [];
    final ref = FirebaseDatabase.instance.ref();
    final snapshots = await ref.child('users').get();
    Map<dynamic, dynamic> values = snapshots.value as Map<dynamic, dynamic>;
    values.forEach((key, values) {
      users.add(MyUser.fromJson(values));
    });
    return users;
  }
}
