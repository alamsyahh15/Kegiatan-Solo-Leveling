import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ma_laundry/data/model/inbox_model/chat_model.dart';
import 'package:ma_laundry/ui/config/bubble_chat.dart';
import 'package:ma_laundry/ui/config/filter_sheet.dart';
import 'package:photo_view/photo_view.dart';
import 'export_config.dart';

/// Chat Widget
Widget senderWidget(String content, {String time}) {
  return Container(
    margin: EdgeInsets.only(top: normal + small),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BubbleSpecialOne(
          text: content,
          times: time,
          isSender: true,
          color: Color(0xFFE2FFC7),
          tail: true,
          seen: true,
        ),
      ],
    ),
  );
}

Widget receiverWidget(DataChat data) {
  return Container(
    margin: EdgeInsets.only(top: normal + small),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Colors.orange,
          child: Text(data.senderName[0].toUpperCase()),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            BubbleSpecialOne(
              text: data?.chat,
              senderName: data?.senderName,
              isSender: false,
              color: Color(0xAF6AD0F5),
            ),
            Container(
              padding: EdgeInsets.only(right: normal),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  data?.createdDate ?? "",
                  style: sansPro(fontSize: 10),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

/// Custom RaisedButton
class CustomRaisedButton extends StatelessWidget {
  final String title;
  final Function onPressed;

  const CustomRaisedButton({Key key, this.title, @required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthScreen(context),
      height: 45,
      // ignore: deprecated_member_use
      child: RaisedButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(small)),
        color: primaryColor,
        textColor: whiteNeutral,
        onPressed: () {
          if (onPressed != null) {
            onPressed();
          }
        },
        child: Text("${title ?? ""}"),
      ),
    );
  }
}

/// Custom OutlineButton
class CustomOutlineButton extends StatelessWidget {
  final String title;
  final Function onPressed;

  const CustomOutlineButton({Key key, this.title, @required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthScreen(context),
      // ignore: deprecated_member_use
      child: OutlineButton(
        borderSide: BorderSide(color: primaryColor),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(small)),
        textColor: primaryColor,
        onPressed: () {
          if (onPressed != null) {
            onPressed();
          }
        },
        child: Text("${title ?? ""}"),
      ),
    );
  }
}

/// Header Search Widget
class HeaderSearch extends StatefulWidget {
  final Function(String query) onSearch;
  final Function onReset;
  final Function onCancelSearch;
  final Function onAddData;
  final Function onCheckNomor;
  final Function(
    DateTime dateFrom,
    DateTime dateTo,
    String filterBy,
    String statusBy,
    String konsumenBy,
    String kurirBy,
  ) onSubmitFilter;
  final bool showAddButton;
  final bool showCheckNomor;
  final bool showFilterByStatus, showFilterRequest;
  final bool showPembayaran;
  const HeaderSearch({
    Key key,
    this.onSearch,
    this.onAddData,
    this.onSubmitFilter,
    this.showAddButton = true,
    this.onCancelSearch,
    this.onReset,
    this.onCheckNomor,
    this.showCheckNomor = false,
    this.showFilterByStatus = false,
    this.showFilterRequest = false,
    this.showPembayaran = false,
  }) : super(key: key);
  @override
  _HeaderSearchState createState() => _HeaderSearchState();
}

class _HeaderSearchState extends State<HeaderSearch> {
  bool isSearch = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthScreen(context),
      padding: EdgeInsets.symmetric(vertical: normal, horizontal: normal),
      decoration: BoxDecoration(
        color: whiteNeutral,
        boxShadow: [
          BoxShadow(color: darkColor, blurRadius: normal),
        ],
      ),
      child: isSearch
          ? CustomTextField(
              hint: "Search....",
              prefixIcon: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() => isSearch = !isSearch);
                    if (widget.onCancelSearch != null) {
                      widget.onCancelSearch();
                    }
                  }),
              onChanged: (val) {
                if (widget.onSearch != null) {
                  widget.onSearch(val);
                }
              },
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: widget.showAddButton,
                  child: Flexible(
                    child: Container(
                      width: widthScreen(context),
                      // ignore: deprecated_member_use
                      child: RaisedButton.icon(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(small)),
                        color: primaryColor,
                        textColor: whiteNeutral,
                        onPressed: () {
                          if (widget.onAddData != null) {
                            widget.onAddData();
                          }
                        },
                        icon: Icon(Icons.add, size: 20),
                        label: Text("Tambah"),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.showCheckNomor,
                  child: Flexible(
                    child: Container(
                      width: widthScreen(context),
                      // ignore: deprecated_member_use
                      child: RaisedButton.icon(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(small)),
                        color: primaryColor,
                        textColor: whiteNeutral,
                        onPressed: () {
                          if (widget.onCheckNomor != null) {
                            widget.onCheckNomor();
                          }
                        },
                        icon: Icon(Icons.location_searching, size: 20),
                        label: Text("Check"),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.showAddButton || widget.showCheckNomor,
                  child: SizedBox(width: small),
                ),
                Flexible(
                  child: Container(
                    width: widthScreen(context),
                    // ignore: deprecated_member_use
                    child: RaisedButton.icon(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(small)),
                      color: primaryColor,
                      textColor: whiteNeutral,
                      onPressed: () {
                        filterDiloag();
                      },
                      icon: Icon(Icons.short_text, size: 20),
                      label: Text("Filter"),
                    ),
                  ),
                ),
                SizedBox(width: small),
                Flexible(
                  child: Container(
                    width: widthScreen(context),
                    // ignore: deprecated_member_use
                    child: RaisedButton.icon(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(small)),
                      color: primaryColor,
                      textColor: whiteNeutral,
                      onPressed: () {
                        setState(() => isSearch = !isSearch);
                      },
                      icon: Icon(Icons.search, size: 20),
                      label: Text("Search"),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Future filterDiloag() async {
    showBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return FilterSheet(
          showFilterRequest: widget.showFilterRequest,
          showPembayaran: widget.showPembayaran,
          showFilterByStatus: widget.showFilterByStatus,
          onReset: () {
            if (widget.onReset != null) {
              widget.onReset();
            }
          },
          onSubmit:
              (dateFrom, dateTo, filterBy, statusBy, konsumenBy, kurirBy) {
            if (widget.onSubmitFilter != null) {
              widget.onSubmitFilter(
                  dateFrom, dateTo, filterBy, statusBy, konsumenBy, kurirBy);
            }
          },
        );
      },
    );
  }
}

/// Zoom Foto Widget
class ZoomFoto extends StatelessWidget {
  final File file;
  final String url;

  const ZoomFoto({Key key, this.file, this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: PhotoView(
          imageProvider: file != null ? FileImage(file) : NetworkImage(url),
          tightMode: true,
          heroAttributes: const PhotoViewHeroAttributes(tag: "someTag"),
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 1.8,
          initialScale: PhotoViewComputedScale.contained,
          basePosition: Alignment.center,
          loadingBuilder: (context, progress) => Center(
            child: Container(
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator(
                value: progress == null
                    ? null
                    : progress.cumulativeBytesLoaded /
                        progress.expectedTotalBytes,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

zoomFotoDialog(context, {File file, String url}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Show Image"),
      content: PhotoView(
        imageProvider: file != null ? FileImage(file) : NetworkImage(url),
        tightMode: true,
        heroAttributes: const PhotoViewHeroAttributes(tag: "someTag"),
        minScale: PhotoViewComputedScale.contained * 0.8,
        maxScale: PhotoViewComputedScale.covered * 1.8,
        initialScale: PhotoViewComputedScale.contained,
        basePosition: Alignment.center,
        loadingBuilder: (context, progress) => Center(
          child: Container(
            width: 20.0,
            height: 20.0,
            child: CircularProgressIndicator(
              value: progress == null
                  ? null
                  : progress.cumulativeBytesLoaded /
                      progress.expectedTotalBytes,
            ),
          ),
        ),
      ),
    ),
  );
}

/// Dialog note Cancel
dialogNoteCancel(BuildContext context, {Function(String note) onSubmit}) {
  String _note;
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Note", style: sansPro(fontWeight: FontWeight.w700)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(
            minLines: 3,
            maxLines: 10,
            onChanged: (val) {
              _note = val;
            },
          ),
        ],
      ),
      actions: [
        Container(
          margin: EdgeInsets.all(normal),
          height: 40,
          // ignore: deprecated_member_use
          child: OutlineButton(
            borderSide: BorderSide(color: primaryColor),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(small)),
            child: Text("Close"),
            textColor: primaryColor,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        Container(
          margin: EdgeInsets.all(normal),
          height: 40,
          // ignore: deprecated_member_use
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(small)),
            child: Text("Submit"),
            textColor: whiteNeutral,
            color: primaryColor,
            onPressed: () {
              onSubmit(_note);
            },
          ),
        ),
      ],
    ),
  );
}

/// Widget Action Order
Widget actionOrderButton({
  Function() onDetail,
  Function() onComplete,
  Function() onCancel,
  Function() onSetKurir,
  Function() onNonaktif,
  bool visibleComplete = true,
  bool visibleCancel = true,
  bool visibleDetail = true,
  bool requestType = false,
  bool visibleNonaktif = false,
  String statusNonAktif = "NONAKTIF",
}) {
  return Column(
    children: [
      Visibility(
        visible: visibleDetail,
        child: Container(
          width: 110,
          // ignore: deprecated_member_use
          child: RaisedButton.icon(
            color: whiteNeutral,
            onPressed: () {
              onDetail();
            },
            icon: Icon(Icons.visibility, size: 15, color: Colors.blue),
            label: Text("Detail", style: sansPro(fontSize: 13)),
          ),
        ),
      ),
      Visibility(
        visible: requestType,
        child: Container(
          width: 110,
          // ignore: deprecated_member_use
          child: RaisedButton.icon(
            color: whiteNeutral,
            onPressed: () {
              onSetKurir();
            },
            icon: Icon(Icons.edit, size: 15, color: Colors.blue),
            label: Text("Set Kurir", style: sansPro(fontSize: 13)),
          ),
        ),
      ),
      Visibility(
        visible: visibleComplete,
        child: Container(
          width: 110,
          // ignore: deprecated_member_use
          child: RaisedButton.icon(
            color: whiteNeutral,
            onPressed: () {
              onComplete();
            },
            icon: Icon(Icons.check, size: 15, color: Colors.green),
            label: Text("Complete", style: sansPro(fontSize: 13)),
          ),
        ),
      ),
      Visibility(
        visible: visibleCancel,
        child: Container(
          width: 110,
          // ignore: deprecated_member_use
          child: RaisedButton.icon(
            color: whiteNeutral,
            onPressed: () {
              onCancel();
            },
            icon: Icon(Icons.clear, size: 15, color: Colors.red),
            label: Text("Cancel", style: sansPro(fontSize: 13)),
          ),
        ),
      ),
      Visibility(
        visible: visibleNonaktif,
        child: Container(
          width: 110,
          // ignore: deprecated_member_use
          child: RaisedButton.icon(
            color: whiteNeutral,
            onPressed: () {
              if (onNonaktif != null) {
                onNonaktif();
              }
            },
            icon: Icon(
              Icons.logout,
              size: 15,
              color: statusNonAktif == "NONAKTIF" ? primaryColor : Colors.red,
            ),
            label: Text(
              statusNonAktif == "NONAKTIF" ? "Aktif" : "Nonaktif",
              style: sansPro(fontSize: 13),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget notFoundDataStatus() {
  return Center(child: Text("No data available in table"));
}

/// Snackbar
Future showLocalSnackbar(content, GlobalKey<ScaffoldState> key) async {
  // ignore: deprecated_member_use
  key.currentState.showSnackBar(SnackBar(content: Text("$content")));
}

/// Label Progress
Widget labelProgress(String status) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: normal),
    padding: EdgeInsets.symmetric(vertical: normal, horizontal: medium),
    child: Text(
      "$status",
      style: sansPro(color: whiteNeutral, fontSize: 12),
    ),
    decoration: BoxDecoration(
        color: () {
          if (status == "CANCELED" ||
              status == "DITOLAK" ||
              status == "NONAKTIF") {
            return Colors.red;
          }
          if (status == "PROGRESS" || status == "MENUNGGU") {
            return labelColor;
          }
          if (status == "COMPLETED" ||
              status == "DISETUJUI" ||
              status == "AKTIF") {
            return primaryColor;
          }
          return labelColor;
        }(),
        borderRadius: BorderRadius.circular(100)),
  );
}

/// Circular Progress Indicator
Widget circularProgressIndicator() {
  return Center(
      child: CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
  ));
}

/// Confirm Dialog
Future customConfirmDialog(context,
    {String content = "", Function() yesButton, Function() noButton}) async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Confirm",
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "$content",
            style: sansPro(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ],
      ),
      actions: [
        Container(
          margin: EdgeInsets.all(normal),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Container(
                  height: 45,
                  width: widthScreen(context),
                  // ignore: deprecated_member_use
                  child: OutlineButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(normal)),
                    color: whiteNeutral,
                    borderSide: BorderSide(color: primaryColor),
                    child: Text("No"),
                    textColor: primaryColor,
                    onPressed: () {
                      noButton();
                    },
                  ),
                ),
              ),
              SizedBox(width: medium),
              Flexible(
                child: Container(
                  height: 45,
                  width: widthScreen(context),
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(normal)),
                    color: primaryColor,
                    textColor: whiteNeutral,
                    child: Text("Yes"),
                    onPressed: () {
                      yesButton();
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}

/// Progress Dialog
progressDialog(BuildContext context) {
  showGeneralDialog(
      barrierDismissible: false,
      barrierColor: Colors.black45.withOpacity(0.65),
      context: context,
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, animation1, animation2) => Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor)),
          ));
}

Widget disableTextField({String hint}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(hint ?? "", style: sansPro(fontWeight: FontWeight.w600)),
      Container(
        padding: EdgeInsets.symmetric(vertical: medium + normal),
        decoration: BoxDecoration(
          color: greyNeutral,
          border: Border.all(color: greyColor),
          borderRadius: BorderRadius.circular(normal),
        ),
      ),
    ],
  );
}

/// Custom Text Field
class CustomTextField extends StatefulWidget {
  final String label;
  final readOnly;
  final bool autoValidate;
  final String hint;
  final TextStyle labelStyle;
  final String initialValue;
  final Function(String value) onChanged;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final int minLines;
  final TextEditingController controller;
  final int maxLines;
  final Function onEditingComplete;
  final EdgeInsetsGeometry contentPadding;
  final bool showCodeDefaultNum;
  const CustomTextField({
    Key key,
    this.label = "",
    this.onChanged,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPadding,
    this.minLines = 1,
    this.maxLines = 1,
    this.hint = "",
    this.readOnly = false,
    this.initialValue,
    this.keyboardType,
    this.onEditingComplete,
    this.controller,
    this.autoValidate = false,
    this.labelStyle,
    this.showCodeDefaultNum = false,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String value = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(
              visible: widget?.label?.isNotEmpty,
              child: Text("${widget?.label}",
                  style: widget?.labelStyle ??
                      sansPro(fontWeight: FontWeight.w600)),
            ),
            Visibility(
              visible: widget?.autoValidate == true,
              child: widget.controller != null
                  ? Text(
                      widget.controller.text.isEmpty ? "Form Wajib Diisi" : "",
                      style: sansPro(color: Colors.red))
                  : Text(value.isEmpty ? "Form Wajib Diisi" : "",
                      style: sansPro(color: Colors.red)),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.only(left: medium, right: normal),
          decoration: BoxDecoration(
              color: widget.readOnly ? greyNeutral : Colors.transparent,
              border: widget.autoValidate == true
                  ? widget.controller != null
                      ? Border.all(
                          color: widget.controller.text.isEmpty
                              ? Colors.red
                              : greyColor)
                      : Border.all(
                          color: value.isEmpty ? Colors.red : greyColor)
                  : Border.all(color: greyColor),
              borderRadius: BorderRadius.all(Radius.circular(normal))),
          child: Row(
            children: [
              Visibility(
                visible: widget.showCodeDefaultNum,
                child: Container(
                  margin: EdgeInsets.only(right: medium),
                  child: Text(
                    "+62",
                    style: sansPro(fontSize: 16),
                  ),
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: widget.controller,
                  keyboardType: widget.keyboardType,
                  initialValue: widget.controller != null
                      ? null
                      : widget.initialValue ?? "",
                  readOnly: widget.readOnly,
                  textInputAction: widget.maxLines < 1
                      ? TextInputAction.done
                      : TextInputAction.newline,
                  minLines: widget.minLines,
                  maxLines: widget.maxLines,
                  obscureText: widget.obscureText,
                  onEditingComplete: widget.onEditingComplete == null
                      ? null
                      : () {
                          widget.onEditingComplete();
                          FocusScope.of(context).unfocus();
                        },
                  onChanged: (val) {
                    widget.onChanged(val);
                    setState(() {
                      value = val;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: widget.hint,
                    hintStyle: widget.readOnly
                        ? TextStyle(color: Colors.black)
                        : TextStyle(),
                    border: InputBorder.none,
                    prefixIcon: widget.prefixIcon,
                    suffixIcon: widget.suffixIcon,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Border Dropdown
Widget borderDropdown({Widget child, bool autovalidate = false, var value}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: autovalidate
              ? Border.all(
                  color: value == null ? Colors.red : greyColor,
                  style: BorderStyle.solid,
                  width: 0.80)
              : Border.all(
                  color: greyColor, style: BorderStyle.solid, width: 0.80),
        ),
        child: child,
      ),
    ],
  );
}

/// Detail Item2
Widget detailItem2(context,
    {String title, String content, TextStyle styleContent}) {
  return Container(
    margin: EdgeInsets.only(top: medium),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
              padding: EdgeInsets.only(right: normal),
              width: widthScreen(context),
              child: Text(
                title ?? "n/a",
                style: sansPro(fontWeight: FontWeight.w600),
              )),
        ),
        Flexible(
          child: Container(
              width: widthScreen(context),
              child: Text(
                ": ${content ?? ""}",
                style: styleContent ?? sansPro(),
              )),
        ),
      ],
    ),
  );
}
