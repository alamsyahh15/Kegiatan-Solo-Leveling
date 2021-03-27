import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ma_laundry/data/model/inbox_model/chat_model.dart';
import 'package:ma_laundry/data/model/inbox_model/inbox_model.dart';
import 'package:ma_laundry/data/model/inbox_model/new_inbox_model.dart';
import 'package:ma_laundry/data/model/inbox_model/user_chat_model.dart';
import 'package:ma_laundry/data/network/network_export.dart';

class InboxRepository {
  /// API Send Chat
  Future sendChat(DataInbox data, String chat) async {
    try {
      Response res = await dio.post(
        INBOX_URL + "sendChat/${data.idInbox}",
        data: FormData.fromMap({'chat': chat}),
        options: Options(headers: apiHeader.headers),
      );
      if (res.statusCode == 200) {
        return res.data;
      }
    } on DioError catch (e, st) {
      log("Exception $e");
      return DioHandler.parseDioErrorMessage(e, st);
    } catch (e) {
      log("Exception $e");
      return e;
    }
  }

  /// API Get Chat
  Future getChat(DataInbox data) async {
    try {
      Response res = await dio.get(
        INBOX_URL + "getChat",
        queryParameters: {'id_inbox': '${data?.idInbox}'},
        options: Options(headers: apiHeader.headers),
      );
      if (res.statusCode == 200) {
        return ChatModel.fromJson(res.data).data;
      }
    } on DioError catch (e, st) {
      log("Exception $e");
      return DioHandler.parseDioErrorMessage(e, st);
    } catch (e) {
      log("Exception $e");
      return e;
    }
  }

  /// API Get Inbox
  Future getInbox() async {
    try {
      Response res = await dio.get(
        INBOX_URL + "getInbox",
        options: Options(headers: apiHeader.headers),
      );
      if (res.statusCode == 200) {
        return InboxModel.fromJson(res.data).data;
      }
    } on DioError catch (e, st) {
      log("Exception $e");
      return DioHandler.parseDioErrorMessage(e, st);
    } catch (e) {
      log("Exception $e");
      return e;
    }
  }

  /// API Get User Chat
  Future getUserChat() async {
    try {
      Response res = await dio.get(
        INBOX_URL + "getUsers",
        options: Options(headers: apiHeader.headers),
      );
      if (res.statusCode == 200) {
        return UserChatModel.fromJson(res.data).data;
      }
    } on DioError catch (e, st) {
      log("Exception $e");
      return DioHandler.parseDioErrorMessage(e, st);
    } catch (e) {
      log("Exception $e");
      return e;
    }
  }

  /// API create new inbox
  Future createInbox(UserChat userChat) async {
    try {
      Response res = await dio.get(
        INBOX_URL + "new_inbox",
        queryParameters: {'id_konsumen': "${userChat.id}"},
        options: Options(headers: apiHeader.headers),
      );
      if (res.statusCode == 200) {
        return DataInbox.fromJson(res.data['data']);
      }
    } on DioError catch (e, st) {
      log("Exception $e");
      return DioHandler.parseDioErrorMessage(e, st);
    } catch (e) {
      log("Exception $e");
      return e;
    }
  }
}

final inboxRepo = InboxRepository();
