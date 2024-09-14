import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gchat/utils/app_styles.dart';
import 'package:gchat/utils/responsive_calculation.dart';
import 'package:gchat/viewmodels/profile_model.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read<ProfileModel>().fetchUserName();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: context.watch<ProfileModel>().loading
          ? Center(child: CircularProgressIndicator())
          : Container(
              color: const Color(0xffF6F6F6),
              child: SafeArea(
                child: Column(
                  children: [
                    Material(
                      elevation: 2,
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 20.rh),
                        height: 85.rh,
                        width: 375.w,
                        child: Text("Profile",
                            style: myStyle.copyWith(
                                fontSize: 36.rt, fontWeight: FontWeight.w700)),
                      ),
                    ),
                    SizedBox(
                      height: 29.h,
                    ),
                    Container(
                      width: 375.rw,
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(horizontal: 24.w),
                      padding: EdgeInsets.symmetric(
                          vertical: 27.h, horizontal: 20.rw),
                      child: Row(
                        children: [
                          Container(
                            width: 76.rw, // Diameter of the circle
                            height: 76.rw,
                            decoration: const BoxDecoration(
                              color: Color(
                                  0xffE8C483), // Background color of the circle
                              shape: BoxShape.circle, // Shape of the container
                            ),
                            child: Center(
                              child: Text(
                                context.read<ProfileModel>().processInitials(
                                    context.read<ProfileModel>().userName),
                                style: myStyle.copyWith(
                                    fontSize: 32.rt,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 14.rw,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.read<ProfileModel>().userName,
                                style: myStyle.copyWith(
                                  fontSize: 16.rt,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: 8.rh,
                              ),
                              Text(
                                context
                                        .read<ProfileModel>()
                                        .authenticate
                                        .currentUser!
                                        .email ??
                                    "",
                                style: myStyle.copyWith(
                                    fontSize: 14.rt,
                                    fontWeight: FontWeight.w400,
                                    height: (16.94 / 14).rt),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 42.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<ProfileModel>().signOut(context);
                      },
                      child: Text(
                        "Logout",
                        style: myStyle.copyWith(
                            fontSize: 14.rt,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff2C57A6)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
