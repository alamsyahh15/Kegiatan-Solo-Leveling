import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:math' hide log;
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ma_laundry/data/local/app_config.dart';
import 'package:ma_laundry/data/model/account_model.dart/account_model.dart';
import 'package:ma_laundry/data/model/account_model.dart/app_config_model.dart';
import 'package:ma_laundry/data/model/data_order_model/data_order_model.dart'
    hide User;
import 'package:ma_laundry/data/model/inbox_model/inbox_model.dart';
import 'package:ma_laundry/data/model/notification_model/notification_model.dart';
import 'package:ma_laundry/data/network/api_endpoint.dart';
import 'package:ma_laundry/data/network/network_export.dart';
import 'package:ma_laundry/data/network/repository/export_repo.dart';
import 'package:ma_laundry/ui/bloc/inbox_bloc/chat_realtime_service.dart';
import 'package:ma_laundry/ui/config/export_config.dart';
import 'package:ma_laundry/ui/main/inbox_screen/chat_page.dart';
import 'package:ma_laundry/ui/main/order_screen/detail_order_page.dart';
import 'package:ma_laundry/utils/export_utils.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPluginStatic =
    FlutterLocalNotificationsPlugin();

Future<void> _onBackgroundMessage(Map<String, dynamic> message) async {
  await Firebase.initializeApp();
  debugPrint('onBackgroundMessage: $message');
  final android = AndroidNotificationDetails(
      'channel_id', 'channel_name', 'channel_description',
      icon: '@drawable/icon',
      largeIcon: const DrawableResourceAndroidBitmap('icon'),
      priority: Priority.high,
      importance: Importance.max,
      channelShowBadge: true);
  final iOS = IOSNotificationDetails(
      presentBadge: true, presentSound: true, presentAlert: true);
  final platform = NotificationDetails(android: android, iOS: iOS);
  try {
    if (message['data']['type'] == "CHAT") {
      await flutterLocalNotificationsPluginStatic.show(
        new Random().nextInt(100),
        message['data']['title'],
        message['data']['body'],
        platform,
        payload: jsonEncode(message['data']),
      );
    } else {
      await flutterLocalNotificationsPluginStatic.show(
        new Random().nextInt(100),
        message['notification']['title'],
        message['notification']['body'],
        platform,
        payload: jsonEncode(message['data']),
      );
    }
  } catch (e) {
    await flutterLocalNotificationsPluginStatic.show(
      new Random().nextInt(100),
      message['data']['title'],
      message['data']['body'],
      platform,
      payload: jsonEncode(message['data']),
    );
  }
}

class NotificationHandler extends ChangeNotifier with ChatRealtimeService {
  /// ==== Constructor ====
  NotificationHandler(this.context) {
    this.init();
  }

  /// ==== Initial ====
  init() async {
    initNotif();
    await listenerFirebase();
    await getNotif();
    await getAppConfig();
  }

  void initNotif() {
    var android = new AndroidInitializationSettings('icon');
    var ios = new IOSInitializationSettings(
      defaultPresentAlert: true,
      defaultPresentBadge: true,
      requestAlertPermission: true,
      requestSoundPermission: true,
      requestBadgePermission: true,
      defaultPresentSound: true,
    );
    var platform = new InitializationSettings(android: android, iOS: ios);
    flutterLocalNotificationsPlugin.initialize(
      platform,
      onSelectNotification: onSelectNotification,
    );
  }

  Future<void> onSelectNotification(String json) async {
    navigationHandler(json);
  }

  // ==== Property ====
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  BuildContext context;
  List<DataNotif> _listNotif = [];
  bool isChat = false;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    try {
      _isLoading = val;
      notifyListeners();
    } catch (e) {}
  }

  List<DataNotif> get listNotif => _listNotif;
  set listNotif(List<DataNotif> val) {
    _listNotif = val;
    notifyListeners();
  }

  /// ==== Method ====
  Future listenerFirebase() async {
    /// Configuration Set Token
    String token = await firebaseMessaging.getToken();
    firebaseMessaging.onTokenRefresh.listen((event) async {
      /// Set Token To Server SQL

      User user = User();
      user.firebaseToken = event.toString();
      await accountRepo.setFirebaseToken(user);
    });

    var android = new AndroidInitializationSettings('icon');
    var ios = new IOSInitializationSettings();
    var platform = new InitializationSettings(android: android, iOS: ios);
    flutterLocalNotificationsPlugin.initialize(
      platform,
      onSelectNotification: onSelectNotification,
    );
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        debugPrint('onMessage: $message');
        showLocalNotif(message);
        addNewMessage(message);
      },
      onBackgroundMessage: (_onBackgroundMessage),
      onResume: (message) async {
        navigationHandler(jsonEncode(message['data']));
        addNewMessage(message);
      },
      onLaunch: (message) async {
        navigationHandler(jsonEncode(message['data']));
        addNewMessage(message);
      },
    );

    firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: true),
    );
    firebaseMessaging.onIosSettingsRegistered.listen((settings) {
      debugPrint('Settings registered: $settings');
    });
  }

  // Show Local Notification
  Future showLocalNotif(Map<String, dynamic> message) async {
    final android = AndroidNotificationDetails(
        'channel_id', 'channel_name', 'channel_description',
        icon: 'icon',
        largeIcon: const DrawableResourceAndroidBitmap('icon'),
        priority: Priority.high,
        importance: Importance.max,
        channelShowBadge: true);
    final iOS = IOSNotificationDetails(
        presentBadge: true, presentSound: true, presentAlert: true);
    final platform1 = NotificationDetails(android: android, iOS: iOS);

    try {
      if (message['data']['type'] == "CHAT") {
        await flutterLocalNotificationsPluginStatic.show(
          new Random().nextInt(100),
          message['data']['title'],
          message['data']['body'],
          platform1,
          payload: jsonEncode(message['data']),
        );
      } else {
        await flutterLocalNotificationsPluginStatic.show(
          new Random().nextInt(100),
          message['notification']['title'],
          message['notification']['body'],
          platform1,
          payload: jsonEncode(message['data']),
        );
      }
    } catch (e) {
      await flutterLocalNotificationsPluginStatic.show(
        new Random().nextInt(100),
        message['data']['title'],
        message['data']['body'],
        platform1,
        payload: jsonEncode(message['data']),
      );
    }
  }

  // App Config
  Future getAppConfig() async {
    try {
      Response res = await dio.get(
        APP_CONFIG_URL,
        options: Options(headers: apiHeader.headers),
      );
      if (res.statusCode == 200) {
        var result = AppConfigModel.fromJson(res.data);
        appConfigData.appConfig = result;
      }
    } on DioError catch (e, st) {
      log("Exception $e");
      return DioHandler.parseDioErrorMessage(e, st);
    } catch (e) {
      log("Exception $e");
      return e;
    }
  }

  // Get Notif
  Future getNotif() async {
    isLoading = true;
    try {
      Response res = await dio.get(
        NOTIFICATION_URL,
        options: Options(headers: apiHeader.headers),
      );
      if (res.statusCode == 200) {
        listNotif = NotificationModel.fromJson(res.data).data;
      }
    } on DioError catch (e, st) {
      log("Exception $e");
      return DioHandler.parseDioErrorMessage(e, st);
    } catch (e) {
      log("Exception $e");
      return e;
    } finally {
      isLoading = false;
    }
  }

  navigationHandler(String json) async {
    log("Json $json");
    if (json != null) {
      Map<String, dynamic> dataDec = jsonDecode(json);

      if (dataDec['type_notif'] == "PAYMENT") {
        progressDialog(context);

        DataOrder dataOrder =
            DataOrder(idTransaksi: int.parse(dataDec['id_order']));
        DataOrder data;
        var res = await orderRepo.getDetailLaundry(dataOrder);
        Navigator.pop(context);
        if (res != null) {
          data = res[0];
          navigateTo(
              context, DetailOrderPage(data: data, showPembayaran: true));
        }
      }

      if (dataDec['type_notif'] == "REQUEST_JEMPUT") {
        DataOrder dataOrder =
            DataOrder(idTransaksi: int.parse(dataDec['id_order']));
        DataOrder data;
        progressDialog(context);
        var res = await orderRepo.getDetailLaundry(dataOrder);
        Navigator.pop(context);
        if (res != null) {
          data = res[0];
          navigateTo(context, DetailOrderPage(data: data));
        }
      }

      if (dataDec['type_notif'] == "REQUEST_ANTAR") {
        DataOrder dataOrder =
            DataOrder(idTransaksi: int.parse(dataDec['id_order']));
        DataOrder data;
        progressDialog(context);
        var res = await orderRepo.getDetailLaundry(dataOrder);
        Navigator.pop(context);
        if (res != null) {
          data = res[0];
          navigateTo(context, DetailOrderPage(data: data));
        }
      }
      if (dataDec['type'] == "CHAT") {
        DataInbox dataInbox = DataInbox(
          idInbox: int.parse(dataDec['id_inbox']),
        );
        navigateTo(context, ChatPage(data: dataInbox));
      }
    }
  }
}
