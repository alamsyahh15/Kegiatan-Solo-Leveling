import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ma_laundry/data/local/account_data.dart';
import 'package:ma_laundry/data/model/inbox_model/chat_model.dart';
import 'package:ma_laundry/data/model/inbox_model/inbox_model.dart';
import 'package:ma_laundry/data/network/repository/inbox_repository/inbox_repository.dart';
import 'package:ma_laundry/ui/bloc/inbox_bloc/chat_realtime_service.dart';
import 'package:ma_laundry/ui/config/export_config.dart';
import 'package:ma_laundry/utils/export_utils.dart';

class ChatBloc extends ChangeNotifier with ChatRealtimeService {
  ///  Constructor

  ChatBloc(this.context, this.dataInbox, {this.key}) {
    this.init();
  }

  /// Initial
  void init() async {
    isLoading = true;
    await getChat();
    onListenNewMessage((event) {
      if (event.isNotEmpty) {
        getChat();
      }
    });
    isLoading = false;
  }

  /// Property
  BuildContext context;
  DataInbox dataInbox;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  List<DataChat> listDataChat = [];
  ScrollController controller = ScrollController();
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  // Getter Setter
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    try {
      notifyListeners();
      _isLoading = val;
    } catch (e) {}
  }

  /// Method
  // Get Chat
  Future getChat() async {
    try {
      var res = await inboxRepo.getChat(dataInbox);
      if (res is! String) {
        listDataChat = res;
        listDataChat.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        scrollToBottom();
      } else {
        showLocalSnackbar(res, key);
      }
      notifyListeners();
    } catch (e) {} finally {
      scrollToBottom();
    }
  }

  // Sending Chat
  Future sendChat(DataInbox data, TextEditingController controller) async {
    if (controller.text.isNotEmpty) {
      try {
        progressDialog(context);
        DataChat dataChat = DataChat(
            chat: controller.text,
            idSender: "${accountData?.account?.id}",
            createdDate: getTimes(dateNow));
        listDataChat.add(dataChat);
        var res = await inboxRepo.sendChat(data, controller.text);
        controller.clear();
        Navigator.pop(context);
        if (res is String) {
          listDataChat.removeLast();
          showLocalSnackbar(res, key);
          notifyListeners();
        }
      } catch (e) {} finally {
        scrollToBottom();
      }
    }
  }

  /// ScroolBottom
  scrollToBottom() {
    if (listDataChat?.length != 0) {
      Future.delayed(Duration(milliseconds: 300), () {
        controller.animateTo(
          controller.position.maxScrollExtent,
          duration: Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
        );
        notifyListeners();
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    disposeStream();
  }
}
