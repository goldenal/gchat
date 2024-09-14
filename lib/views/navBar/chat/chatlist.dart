import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gchat/models/chat/users.dart';
import 'package:gchat/utils/app_styles.dart';
import 'package:gchat/utils/responsive_calculation.dart';
import 'package:gchat/viewmodels/chat_view_model.dart';
import 'package:gchat/views/navBar/chat/chatItem.dart';
import 'package:gchat/views/navBar/chat/chatscreen.dart';
import 'package:provider/provider.dart';

class Chatlist extends StatefulWidget {
  const Chatlist({super.key});

  @override
  State<Chatlist> createState() => _ChatlistState();
}

class _ChatlistState extends State<Chatlist> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read<ChatViewModel>().loadUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: context.watch<ChatViewModel>().loading
          ? Center(child: CircularProgressIndicator())
          : Container(
              height: 812.rh,
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
                        child: Text("Chats",
                            style: myStyle.copyWith(
                                fontSize: 36.rt, fontWeight: FontWeight.w700)),
                      ),
                    ),
                    SizedBox(
                      height: 29.h,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: context
                            .read<ChatViewModel>()
                            .userdata
                            .myUser!
                            .length,
                        itemBuilder: (context, index) {
                          ChatViewModel model = context.read<ChatViewModel>();
                          MyUser myUser = model.userdata.myUser![index];

                          return GestureDetector(
                            onTap: ()async {
                              String id = await model
                                                .fetchID(myUser.id ?? "");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Chatscreen(
                                            name: myUser.name ?? "",
                                            senderId: model.getSenderID() ?? "",
                                            chatId: id),
                                          ));
                            },
                            child: ChatItem(
                              name: myUser.name ?? "",
                            ),
                          );
                        })
                  ],
                ),
              ),
            ),
    );
  }
}
