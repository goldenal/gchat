import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gchat/utils/app_styles.dart';
import 'package:gchat/utils/responsive_calculation.dart';

class Chatlist extends StatelessWidget {
  const Chatlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xffF6F6F6),
        child: SafeArea(
          child: Column(
            children: [
              Material(
                elevation: 2,
                child: Container(
                  color: Colors.white,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.rh),
                  height: 85.rh,
                  width: 375.w,
                  child: Text("Chats",
                      style: myStyle.copyWith(
                          fontSize: 36.rt, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
