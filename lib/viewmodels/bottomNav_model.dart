import 'package:flutter/widgets.dart';
import 'package:gchat/views/navBar/chat/chatlist.dart';
import 'package:gchat/views/navBar/profile/profile.dart';

class BottomnavModel extends ChangeNotifier {
  int selectedTab = 0;
  List<Widget> body = const [Chatlist(), Profile()];

  setIndex(index) {
    selectedTab = index;
    notifyListeners();
  }
}
