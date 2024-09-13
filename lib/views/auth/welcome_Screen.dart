import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gchat/utils/app_styles.dart';
import 'package:gchat/utils/responsive_calculation.dart';
import 'package:gchat/views/auth/login.dart';
import 'package:gchat/views/auth/register.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localstorage/localstorage.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 375.w,
        height: 812.h,
        color: const Color(0xffF9EFD8),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 232.rh,
              ),
              Image.asset("assets/images/logo.png"),
              Text(
                "Hey!",
                style: myStyle.copyWith(
                    fontSize: 36.sp, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 15.rh,
              ),
              Text(
                "Welcome to GChat",
                style: myStyle.copyWith(
                    fontSize: 16.sp, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 227.rh,
              ),
              GestureDetector(
                onTap: () {
                  localStorage.setItem('onboard', "true");
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SignUp()),
                  );
                },
                child: Container(
                    width: 327.rw,
                    padding: EdgeInsets.symmetric(vertical: 18.rh),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.r),
                      color: const Color(0xff2C57A6),
                    ),
                    child: Center(
                      child: Text(
                        "GET STARTED",
                        style: myStyle.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    )),
              ),
              SizedBox(
                height: 19.rh,
              ),
              GestureDetector(
                onTap: () {
                  localStorage.setItem('onboard', "true");
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Already have an account?",
                        style: myStyle.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                          text: " Login",
                          style: GoogleFonts.roboto(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff2C57A6))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
