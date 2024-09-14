import 'package:gchat/models/chat/users.dart';

abstract class ChatRepository {
  Future<Userdata> fetchUsers();
 
}