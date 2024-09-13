import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gchat/utils/app_styles.dart';
import 'package:gchat/utils/responsive_calculation.dart';
import 'package:gchat/viewmodels/auth_view_model.dart';
import 'package:gchat/views/auth/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? email, password, name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Container(
            color: Colors.white,
            height: 812.h,
            width: 375.w,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back_ios)),
                    SizedBox(
                      height: 11.h,
                    ),
                    Text(
                      "Sign Up",
                      style: myStyle.copyWith(
                          fontSize: 36.sp, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    Text(
                      "Fill out the fields below to register on\nGChat",
                      style: myStyle.copyWith(
                          fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                    SizedBox(
                      width: 375.rw,
                      child: TextFormField(
                        onChanged: (val) {
                          name = val;
                        },
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "Field is required";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "Name",
                            hintStyle: myStyle.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Color(0xff898989))),
                      ),
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                    SizedBox(
                      width: 375.rw,
                      child: TextFormField(
                        onChanged: (val) {
                          email = val;
                        },
                        validator: (v) {
                          if (v!.isEmpty ||
                              !RegExp(r'^[\w-.]+@([\w-]+\.)+\w{2,5}')
                                  .hasMatch(v)) {
                            return "please Enter a correct Email";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: myStyle.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Color(0xff898989))),
                      ),
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                    SizedBox(
                      width: 375.rw,
                      child: TextFormField(
                        onChanged: (val) {
                          password = val;
                        },
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "Field is required";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: myStyle.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Color(0xff898989))),
                      ),
                    ),
                    SizedBox(
                      height: 273.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          context
                              .read<AuthViewModel>()
                              .register(name, password, email, context);
                        }
                      },
                      child: Container(
                          width: 327.rw,
                          padding: EdgeInsets.symmetric(vertical: 18.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.r),
                            color: const Color(0xff2C57A6),
                          ),
                          child: Center(
                            child: context.watch<AuthViewModel>().isLoading
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    "REGISTER",
                                    style: myStyle.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                          )),
                    ),
                    SizedBox(
                      height: 19.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Center(
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
