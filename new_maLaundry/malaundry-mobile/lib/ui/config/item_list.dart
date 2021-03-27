import 'package:flutter/material.dart';
import 'package:ma_laundry/ui/config/export_config.dart';

/// Item List
class ItemList extends StatefulWidget {
  final String kodeTransaction, fullName, date, statusProgress, kurirName;
  final String statusKurir;
  final bool showAction,
      showCancel,
      showComplete,
      requestType,
      visibleDetail,
      visibleNonaktif;
  final Function() showActionButton, hideActionButton;
  final Function() onDetail, onCancel, onComplete, onSetKurir, onNonaktif;
  const ItemList({
    Key key,
    @required this.kodeTransaction,
    @required this.fullName,
    @required this.date,
    this.showAction = false,
    @required this.showActionButton,
    @required this.hideActionButton,
    @required this.onDetail,
    this.onCancel,
    this.onComplete,
    this.showCancel = false,
    this.showComplete = false,
    this.requestType = false,
    this.statusProgress,
    this.visibleDetail = true,
    this.onSetKurir,
    this.statusKurir,
    this.visibleNonaktif = false,
    this.onNonaktif,
    this.kurirName,
  }) : super(key: key);

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.hideActionButton != null) {
          widget.hideActionButton();
        }
      },
      child: Card(
        elevation: 5,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(normal)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding:
                      EdgeInsets.only(top: medium, left: medium, right: medium),
                  child: Text(
                    widget?.kodeTransaction ?? "n/a",
                    style: sansPro(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                Visibility(
                  visible: widget?.statusKurir != null,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: medium, vertical: normal),
                      child: Text("${widget?.statusKurir}",
                          style: sansPro(
                              color: whiteNeutral,
                              fontWeight: FontWeight.w600)),
                      decoration: BoxDecoration(
                        color: () {
                          if (widget.statusKurir == "MENUNGGU") {
                            return labelColor;
                          }
                          if (widget.statusKurir == "DITOLAK") {
                            return Colors.red;
                          }
                          if (widget.statusKurir == "DISETUJUI") {
                            return primaryColor;
                          }
                        }(),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(normal),
                          bottomLeft: Radius.circular(normal),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(medium),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: widget?.kurirName != null,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Kurir : ${widget?.kurirName ?? ""}",
                                style: sansPro(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      Text(widget?.fullName ?? "n/a",
                          style: sansPro(color: greyColor)),
                      SizedBox(height: normal),
                      Text(widget?.date ?? "",
                          style: sansPro(color: greyColor)),
                      Visibility(
                        visible: widget?.statusProgress != null,
                        child: labelProgress(widget.statusProgress),
                      )
                    ],
                  ),
                  widget.showAction
                      ? actionOrderButton(
                          visibleCancel: widget.showCancel,
                          visibleComplete: widget.showComplete,
                          requestType: widget.requestType,
                          visibleDetail: widget.visibleDetail,
                          visibleNonaktif: widget.visibleNonaktif,
                          statusNonAktif: widget.statusProgress,
                          onNonaktif: () {
                            if (widget.onNonaktif != null) {
                              widget.onNonaktif();
                            }
                          },
                          onSetKurir: () {
                            if (widget.onSetKurir != null) {
                              widget.onSetKurir();
                            }
                          },
                          onDetail: () {
                            if (widget.hideActionButton != null &&
                                widget.onDetail != null) {
                              widget.hideActionButton();
                              widget.onDetail();
                            }
                          },
                          onCancel: () {
                            if (widget.hideActionButton != null &&
                                widget.onCancel != null) {
                              widget.hideActionButton();
                              widget.onCancel();
                            }
                          },
                          onComplete: () {
                            if (widget.hideActionButton != null &&
                                widget.onComplete != null) {
                              widget.hideActionButton();
                              widget.onComplete();
                            }
                          },
                        )
                      : Container(
                          height: 40,
                          // ignore: deprecated_member_use
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(normal)),
                            textColor: whiteNeutral,
                            color: primaryColor,
                            child: Row(
                              children: [
                                Text("Action"),
                                Icon(Icons.keyboard_arrow_down, size: 15)
                              ],
                            ),
                            onPressed: () {
                              if (widget.showActionButton != null) {
                                widget.showActionButton();
                              }
                            },
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
