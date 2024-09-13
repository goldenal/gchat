import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gchat/repository/chat_impl.dart';
import 'package:gchat/viewmodels/bottomNav_model.dart';
import 'package:gchat/viewmodels/profile_model.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    ChatImpl cht = ChatImpl();
    cht.fetchUsers();
    context.watch<ProfileModel>().fetchUserName();
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          onTap: (val) {
            context.read<BottomnavModel>().setIndex(val);
          },
          currentIndex: context.watch<BottomnavModel>().selectedTab,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: TextStyle(
            fontSize: 12.sp,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 12.sp,
          ),
          // unselectedItemColor: secondaryColor,
          selectedItemColor: Color(0xffDEA531),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_pin),
              label: 'Profile',
            ),
          ]),
      body: context
          .read<BottomnavModel>()
          .body[context.read<BottomnavModel>().selectedTab],
    );
  }
}
