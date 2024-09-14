import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gchat/utils/app_styles.dart';
import 'package:gchat/utils/responsive_calculation.dart';
import 'package:gchat/viewmodels/profile_model.dart';
import 'package:provider/provider.dart';

class ChatItem extends StatelessWidget {
  final String name;
  const ChatItem({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375.rw,
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 14.rw),
      child: Row(
        children: [
          Container(
            width: 52.rw, // Diameter of the circle
            height: 52.rw,
            decoration: const BoxDecoration(
              color: Color(0xffE8C483), // Background color of the circle
              shape: BoxShape.circle, // Shape of the container
            ),
            child: Center(
              child: Text(
                context
                    .read<ProfileModel>()
                    .processInitials(name)
                    .toUpperCase(),
                style: myStyle.copyWith(
                    fontSize: 22.rt,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            width: 14.w,
          ),
          Text(
            name,
            style: myStyle.copyWith(
                fontSize: 16.rt,
                fontWeight: FontWeight.w400,
                color: Color(0xff666666),
                height: (16.94 / 14).rt),
          ),
        ],
      ),
    );
  }
}
