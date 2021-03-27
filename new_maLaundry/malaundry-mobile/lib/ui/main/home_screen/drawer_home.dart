import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ma_laundry/data/local/account_data.dart';
import 'package:ma_laundry/ui/config/export_config.dart';
import 'package:ma_laundry/ui/config/filter_sheet.dart';
import 'package:ma_laundry/utils/export_utils.dart';
import '../../../data/local/app_config.dart';

class DrawerHome extends StatelessWidget {
  final List<String> listNameMenu;
  final TabController controller;
  final Function(String menuName) onChangeMenu;

  const DrawerHome(
      {Key key, this.listNameMenu, this.controller, this.onChangeMenu})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: widthScreen(context) * 0.75,
        child: Drawer(
          child: Container(
            color: darkColor,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  /// Design Profile
                  Container(
                    padding: EdgeInsets.only(
                        top: medium, right: medium, left: medium),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: medium),
                          width: 60,
                          height: 60,
                          child: ClipOval(
                            child: Container(
                              color: whiteNeutral,
                              child: Image.network(
                                (appConfigData?.appConfig?.url ?? "") +
                                    (appConfigData?.appConfig?.logo ?? ""),
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.network(
                                      'https://si.malaundry.co.id/logo/20210226154348/logo.png');
                                },
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${accountData?.account?.namaDepan} ${accountData?.account?.namaBelakang}",
                              style: sansPro(
                                  color: whiteNeutral, fontSize: medium),
                            ),
                            SizedBox(height: normal),
                            Text(
                              "${accountData?.account?.level}",
                              style: sansPro(color: whiteNeutral, fontSize: 13),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: medium),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: medium),
                    height: widthScreen(context) * 0.1,
                    width: widthScreen(context),
                    color: darkenColor,
                    child: Text(
                      "MAIN NAVIGATON",
                      style: sansPro(color: whiteNeutral.withOpacity(0.25)),
                    ),
                  ),

                  /// Design Menu
                  menuDrawer()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget menuDrawer() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: listNameMenu?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text("${listNameMenu[index]}",
              style: sansPro(color: whiteNeutral)),
          onTap: () async {
            onChangeMenu(listNameMenu[index]);
            resetFilter();
            if (index == (controller.length)) {
              Navigator.pop(context);
              showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: Text("Do you want logout?"),
                  actions: [
                    CupertinoButton(
                      child: Text("Cancel"),
                      onPressed: () => Navigator.pop(context),
                    ),
                    CupertinoButton(
                      child: Text("Oke"),
                      onPressed: () async {
                        await sessionManager.clearSession(context);
                      },
                    ),
                  ],
                ),
              );
            } else {
              Navigator.pop(context);
              controller.animateTo(index,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.bounceInOut);
            }
          },
        );
      },
    );
  }
}
