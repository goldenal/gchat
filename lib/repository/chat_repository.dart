import 'package:gchat/models/chat/users.dart';

abstract class ChatRepository {
  Future<List<MyUser>> fetchUsers();
 
}