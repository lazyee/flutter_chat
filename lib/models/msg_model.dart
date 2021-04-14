import 'package:flutter_chat/models/contact_model.dart';

class MsgModel {
  ContactModel contact;
  String text;
  String url;
  String voiceUrl;
  MsgType type;
  bool isSender = false;

  MsgModel.text(String text, ContactModel contact, bool isSender) {
    this.text = text;
    this.type = MsgType.text;
    this.contact = contact;
    this.isSender = isSender;
  }
}

enum MsgType {
  text,
  image,
  voice,
}
