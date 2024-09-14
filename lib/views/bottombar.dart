import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gchat/utils/responsive_calculation.dart';
import 'package:gchat/viewmodels/bottomNav_model.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 812.rh,
      width: 374.rw,
      child: Scaffold(
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
      ),
    );
  }
}
