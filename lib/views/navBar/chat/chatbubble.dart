import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gchat/utils/app_styles.dart';

class Chatbubble extends StatelessWidget {
  final bool isSender;
  final String msg;
  const Chatbubble({super.key, required this.isSender, required this.msg});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 24.h),
        padding: EdgeInsets.symmetric(vertical: 9.h, horizontal: 15.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: isSender ? Color(0xffDEA531) : Colors.white,
        ),
        child: Text(
          msg,
          style: myStyle.copyWith(
              color: isSender ? Colors.white : Colors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
