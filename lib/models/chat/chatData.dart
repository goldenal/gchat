// To parse this JSON data, do
//
//     final chatData = chatDataFromJson(jsonString);

import 'dart:convert';

ChatData chatDataFromJson(String str) => ChatData.fromJson(json.decode(str));

String chatDataToJson(ChatData data) => json.encode(data.toJson());

class ChatData {
    List<ChatModel>? chatModel;

    ChatData({
        this.chatModel,
    });

    factory ChatData.fromJson(Map<String, dynamic> json) => ChatData(
        chatModel: json["ChatModel"] == null ? [] : List<ChatModel>.from(json["ChatModel"]!.map((x) => ChatModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ChatModel": chatModel == null ? [] : List<dynamic>.from(chatModel!.map((x) => x.toJson())),
    };
}

class ChatModel {
    String? message;
    String? chatId;
    String? senderId;

    ChatModel({
        this.message,
        this.chatId,
        this.senderId,
    });

    factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        message: json["message"],
        chatId: json["chatId"],
        senderId: json["senderId"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "chatId": chatId,
        "senderId": senderId,
    };
}
