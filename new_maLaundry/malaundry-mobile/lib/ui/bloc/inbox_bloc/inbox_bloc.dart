import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ma_laundry/data/model/inbox_model/inbox_model.dart';
import 'package:ma_laundry/data/model/inbox_model/new_inbox_model.dart';
import 'package:ma_laundry/data/model/inbox_model/user_chat_model.dart';
import 'package:ma_laundry/data/network/repository/inbox_repository/inbox_repository.dart';
import 'package:ma_laundry/ui/config/export_config.dart';
import 'package:ma_laundry/ui/main/inbox_screen/chat_page.dart';
import 'package:ma_laundry/utils/export_utils.dart';

class InboxBloc extends ChangeNotifier {
  /// ==== Constructor ====
  InboxBloc(this.context, {this.key}) {
    this.init();
  }

  InboxBloc.initUser(this.context, {this.key}) {
    this.initGetUser();
  }

  /// ==== Initial ====
  void init() async {
    isLoading = true;
    await getInbox();
    isLoading = false;
  }

  void initGetUser() async {
    isLoading = true;
    await getUserChat();
    isLoading = false;
  }

  /// ==== Property ====
  List<UserChat> listUserChat = [], backupUserChat = [];
  List<DataInbox> listinbox = [], backupInbox = [];
  BuildContext context;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  /// ==== Method ====
  // Get Inbox
  Future getInbox() async {
    var res = await inboxRepo.getInbox();
    if (res is! String) {
      listinbox = res;
      backupInbox.addAll(listinbox);
    } else {
      showLocalSnackbar(res, key);
    }
    notifyListeners();
  }

  // Search Inbox
  void search(String query) {
    listinbox = backupInbox;
    if (query != null && query.isNotEmpty) {
      query = query.toLowerCase();
      listinbox = listinbox
          .where((e) => e.namaKonsumen.toLowerCase().contains(query))
          .toList();
      log("Query${listinbox.length} $query");
    }
    notifyListeners();
  }

  // Search User
  void searchUser(String query) {
    listUserChat = backupUserChat;
    if (query != null && query.isNotEmpty) {
      query = query.toLowerCase();
      listUserChat = listUserChat
          .where((e) => e.namaKonsumen.toLowerCase().contains(query))
          .toList();
    }
    notifyListeners();
  }

  // Get User Chat
  Future getUserChat() async {
    try {
      var res = await inboxRepo.getUserChat();
      if (res is! String) {
        listUserChat = res;
        listUserChat
            .removeWhere((e) => e.level == "ADMIN" || e.level == "OWNER");
        backupUserChat.addAll(listUserChat);
        notifyListeners();
      } else {
        showLocalSnackbar(res, key);
      }
    } catch (e) {}
  }

  // Create New Inbox
  Future createNewInbox(UserChat userChat) async {
    progressDialog(context);
    DataInbox res = await inboxRepo.createInbox(userChat);
    Navigator.pop(context);
    if (res is! String) {
      Navigator.pop(context);
      navigateTo(context, ChatPage(data: res));
    } else {
      showLocalSnackbar(res, key);
    }
  }
}
