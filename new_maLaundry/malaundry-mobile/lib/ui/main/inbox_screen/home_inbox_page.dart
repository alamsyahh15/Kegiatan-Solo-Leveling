import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ma_laundry/data/model/inbox_model/inbox_model.dart';
import 'package:ma_laundry/data/model/inbox_model/user_chat_model.dart';
import 'package:ma_laundry/ui/bloc/inbox_bloc/inbox_bloc.dart';
import 'package:ma_laundry/ui/config/export_config.dart';
import 'package:ma_laundry/ui/config/spacing.dart';
import 'package:ma_laundry/ui/main/inbox_screen/chat_page.dart';
import 'package:ma_laundry/utils/navigator_helper.dart';
import 'package:provider/provider.dart';

class HomeInboxPage extends StatefulWidget {
  @override
  _HomeInboxPageState createState() => _HomeInboxPageState();
}

class _HomeInboxPageState extends State<HomeInboxPage> {
  ScrollController scrollController = ScrollController();
  TextEditingController controller = TextEditingController();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  bool _isVisible = true;
  bool isSearch = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isVisible == true) {
          setState(() => _isVisible = false);
        }
      } else {
        if (scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (_isVisible == false) {
            setState(() => _isVisible = true);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => InboxBloc(context, key: key)),
      ],
      child: Consumer<InboxBloc>(
        builder: (context, inboxBloc, _) => Scaffold(
          key: key,
          body: RefreshIndicator(
            onRefresh: () async {
              inboxBloc.init();
            },
            child: Column(
              children: [
                Container(
                  width: widthScreen(context),
                  padding: EdgeInsets.symmetric(
                      vertical: normal, horizontal: normal),
                  decoration: BoxDecoration(
                    color: whiteNeutral,
                    boxShadow: [
                      BoxShadow(color: darkColor, blurRadius: normal),
                    ],
                  ),
                  child: CustomTextField(
                    controller: controller,
                    hint: "Search....",
                    prefixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          controller.clear();
                          FocusScope.of(context).unfocus();
                        });
                        inboxBloc.init();
                      },
                    ),
                    onChanged: (query) {
                      inboxBloc.search(query);
                    },
                  ),
                ),
                Expanded(
                  child: inboxBloc.isLoading
                      ? circularProgressIndicator()
                      : inboxBloc.listinbox.length == 0
                          ? notFoundDataStatus()
                          : Container(
                              padding: EdgeInsets.all(normal),
                              child: ListView.builder(
                                controller: scrollController,
                                physics: BouncingScrollPhysics(),
                                itemCount: inboxBloc.listinbox.length,
                                itemBuilder: (BuildContext context, int index) {
                                  DataInbox data = inboxBloc.listinbox[index];
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(normal)),
                                    elevation: 5,
                                    child: Container(
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor: Colors.orange,
                                          child: Text(data.namaKonsumen[0]
                                              .toUpperCase()),
                                        ),
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("${data.namaKonsumen}",
                                                style: sansPro(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14)),
                                            SizedBox(width: medium),
                                            Expanded(
                                              child: Text(
                                                "${data?.lastMsgAt}",
                                                style: sansPro(fontSize: 11),
                                                maxLines: 1,
                                                textAlign: TextAlign.right,
                                              ),
                                            )
                                          ],
                                        ),
                                        subtitle: Text("${data.lastMsg}",
                                            style: sansPro(fontSize: 12)),
                                        onTap: () {
                                          navigateTo(
                                              context, ChatPage(data: data));
                                          // inboxBloc.getChat(data, inboxBloc);
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                ),
              ],
            ),
          ),
          floatingActionButton: Visibility(
            visible: _isVisible,
            child: FloatingActionButton(
              backgroundColor: primaryColor,
              child: Icon(Icons.add),
              onPressed: () {
                sheetNewInbox();
              },
            ),
          ),
        ),
      ),
    );
  }

  sheetNewInbox() {
    key.currentState.showBottomSheet(
      (context) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: medium),
            child: Icon(Icons.menu),
          ),
          Expanded(child: SheetNewInbox()),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}

class SheetNewInbox extends StatefulWidget {
  @override
  _SheetNewInboxState createState() => _SheetNewInboxState();
}

class _SheetNewInboxState extends State<SheetNewInbox> {
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => InboxBloc.initUser(context, key: key))
      ],
      child: Consumer<InboxBloc>(
        builder: (context, userBloc, _) => Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            width: widthScreen(context),
            margin: EdgeInsets.only(top: medium),
            padding: EdgeInsets.symmetric(horizontal: medium),
            decoration: BoxDecoration(
              color: whiteNeutral,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(medium),
                topRight: Radius.circular(medium),
              ),
            ),
            child: Column(
              children: [
                CustomTextField(
                  controller: controller,
                  hint: "Search....",
                  prefixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        controller.clear();
                        FocusScope.of(context).unfocus();
                        userBloc.initGetUser();
                      });
                    },
                  ),
                  onChanged: (query) {
                    userBloc.searchUser(query);
                  },
                ),
                SizedBox(height: normal),
                Expanded(
                  child: userBloc.isLoading
                      ? circularProgressIndicator()
                      : userBloc.listUserChat.length == 0
                          ? notFoundDataStatus()
                          : Container(
                              child: ListView.builder(
                                itemCount: userBloc.listUserChat.length,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  UserChat data = userBloc.listUserChat[index];
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(normal)),
                                    elevation: 5,
                                    child: Container(
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor: Colors.orange,
                                          child: Text(data.namaKonsumen[0]
                                              .toUpperCase()),
                                        ),
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("${data.namaKonsumen}",
                                                style: sansPro(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14)),
                                            SizedBox(width: medium),
                                            Expanded(
                                              child: Text(
                                                "${data.lastMsgAt}",
                                                style: sansPro(fontSize: 11),
                                                maxLines: 1,
                                                textAlign: TextAlign.right,
                                              ),
                                            )
                                          ],
                                        ),
                                        onTap: () {
                                          userBloc.createNewInbox(data);
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
