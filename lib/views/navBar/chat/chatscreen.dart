import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gchat/utils/app_styles.dart';
import 'package:gchat/utils/responsive_calculation.dart';
import 'package:gchat/viewmodels/chat_view_model.dart';
import 'package:gchat/views/navBar/chat/chatItem.dart';
import 'package:gchat/views/navBar/chat/chatbubble.dart';
import 'package:provider/provider.dart';

class Chatscreen extends StatefulWidget {
  final String name, chatId, senderId;

  const Chatscreen(
      {super.key,
      required this.name,
      required this.senderId,
      required this.chatId});

  @override
  State<Chatscreen> createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  TextEditingController ctr = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {});
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final model = context.read<ChatViewModel>();

      model.scrollList(_scrollController);
    });
  }

  @override
  Widget build(BuildContext context) {
    ChatViewModel myModel = context.read<ChatViewModel>();

    return Scaffold(
      body: context.watch<ChatViewModel>().loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                height: 812.h,
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
                      SizedBox(
                        height: 10.h,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: StreamBuilder(
                              stream: myModel.refInstance
                                  .ref("chat/${widget.chatId}")
                                  .orderByChild("timestamp")
                                  .onValue,
                              builder: (context, snapshot) {
                                myModel.scrollList(_scrollController);
                                if (snapshot.hasData && snapshot.data != null) {
                                  DataSnapshot dataSnapshot =
                                      snapshot.data!.snapshot;
                                  Map<dynamic, dynamic>? messagesData =
                                      dataSnapshot.value as Map?;
                                  if (messagesData != null) {
                                    List<dynamic> messagesList =
                                        messagesData.values.toList();
                                    messagesList.sort((a, b) {
                                      String timeA = a["timestamp"].toString();
                                      String timeB = b["timestamp"].toString();
                                      return timeA.compareTo(timeB);
                                    });
                                    return ListView.builder(
                                        controller: _scrollController,
                                        // padding: EdgeInsets.only(
                                        //     bottom: MediaQuery.of(context)
                                        //             .viewInsets
                                        //             .bottom +
                                        //         8.h),
                                        shrinkWrap: true,
                                        itemCount: messagesList.length,
                                        itemBuilder: (context, index) {
                                          return Chatbubble(
                                            isSender: messagesList[index]
                                                    ["senderId"] ==
                                                myModel.getSenderID(),
                                            msg: messagesList[index]["message"],
                                          );
                                        });
                                  } else {
                                    return const Center(
                                        child: Text('No messages found'));
                                  }
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Error: ${snapshot.error}'));
                                } else {
                                  return const Center(
                                      child: Text('Fetching message...'));
                                }
                              }),
                        ),
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
                                controller: ctr,
                                maxLines: null,
                                decoration: InputDecoration(
                                    isDense: true,
                                    filled: true,
                                    fillColor: const Color(0xffF2F2F2),
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
                              padding: EdgeInsets.all(7.rw),
                              decoration: const BoxDecoration(
                                color: Color(
                                    0xffF2F2F2), // Background color of the circle
                                shape:
                                    BoxShape.circle, // Shape of the container
                              ),
                              child: GestureDetector(
                                onTap: () async {
                                  await context
                                      .read<ChatViewModel>()
                                      .sendMesssage(ctr.text, widget.senderId,
                                          widget.chatId, _scrollController);
                                  ctr.clear();
                                  FocusScope.of(context).unfocus();
                                },
                                child: const Icon(
                                  Icons.send,
                                  color: Color(0xffDEA531),
                                ),
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
