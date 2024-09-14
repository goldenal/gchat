import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gchat/utils/app_styles.dart';
import 'package:gchat/utils/responsive_calculation.dart';
import 'package:gchat/viewmodels/chat_view_model.dart';
import 'package:gchat/views/navBar/chat/chatItem.dart';
import 'package:provider/provider.dart';

class Chatscreen extends StatefulWidget {
  final String name;
  const Chatscreen({super.key, required this.name});

  @override
  State<Chatscreen> createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      //  context.read<ChatViewModel>().loadUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: context.watch<ChatViewModel>().loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                height: 812.rh,
                color: const Color(0xffF6F6F6),
                child: SafeArea(
                  child: Column(
                    children: [
                      Material(
                        elevation: 2,
                        child: Container(
                          color: Colors.white,
                          height: 85.rh,
                          width: 375.w,
                          child: ChatItem(
                            name: widget.name,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom +
                                        10.h),
                            shrinkWrap: true,
                            itemCount: 20,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 50,
                                color: Colors.blue,
                                child: Text(index.toString()),
                              );
                            }),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        color: Colors.white,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 16.w,
                            ),
                            SizedBox(
                              width: 291.w,
                              child: TextFormField(
                                decoration: InputDecoration(
                                    isDense: true,
                                    filled: true,
                                    fillColor: Color(0xffF2F2F2),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    hintText: "Type Something",
                                    hintStyle: myStyle.copyWith(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Container(
                              padding: EdgeInsets.all(7.w),
                              decoration: const BoxDecoration(
                                color: Color(
                                    0xffF2F2F2), // Background color of the circle
                                shape:
                                    BoxShape.circle, // Shape of the container
                              ),
                              child: const Icon(
                                Icons.send,
                                color: Color(0xffDEA531),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
