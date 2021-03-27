import 'package:flutter/material.dart';
import 'package:ma_laundry/data/model/notification_model/notification_model.dart';
import 'package:ma_laundry/ui/config/error_connect_widget.dart';
import 'package:ma_laundry/ui/config/export_config.dart';
import 'package:ma_laundry/utils/connectivity_handler.dart';
import 'package:ma_laundry/utils/notification_handler.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatefulWidget {
  final NotificationHandler notif;

  const NotificationPage({Key key, this.notif}) : super(key: key);
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  NotificationHandler get notifBloc => widget.notif;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ConnecttivityHandler()),
      ],
      child: Consumer<ConnecttivityHandler>(
        builder: (context, connect, _) => Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context),
            ),
            centerTitle: true,
            title: Text("Notification"),
          ),
          body: Column(
            children: [
              errorConnectWidget(context),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await notifBloc.getNotif().then((value) {
                      setState(() {});
                    });
                    return false;
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        vertical: normal, horizontal: normal),
                    child: notifBloc.isLoading
                        ? circularProgressIndicator()
                        : notifBloc.listNotif.length == 0
                            ? notFoundDataStatus()
                            : ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: notifBloc.listNotif.length,
                                itemBuilder: (BuildContext context, int index) {
                                  DataNotif data = notifBloc.listNotif[index];
                                  return InkWell(
                                    onTap: () {
                                      Navigator.pop(context, data.urlTo);
                                    },
                                    child: Card(
                                      elevation: 5,
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor: Color(0xFF2F80ED)
                                              .withOpacity(0.4),
                                          child: Image.asset(
                                              'assets/images/email_icon.png'),
                                        ),
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${data.sendByName}",
                                              style: sansPro(
                                                fontWeight: data?.isRead != "1"
                                                    ? FontWeight.w700
                                                    : null,
                                              ),
                                            ),
                                            Text(
                                              "${data?.sendAt}",
                                              style: sansPro(fontSize: 10),
                                            ),
                                          ],
                                        ),
                                        subtitle: Text("${data?.title}",
                                            style: sansPro(fontSize: 11)),
                                      ),
                                    ),
                                  );
                                },
                              ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
