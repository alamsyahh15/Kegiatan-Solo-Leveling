import 'package:flutter/material.dart';
import 'package:ma_laundry/data/model/pembayaran_model/detail_pembayaran_model.dart';
import 'package:ma_laundry/data/network/network_export.dart';
import 'package:ma_laundry/ui/config/export_config.dart';
import 'package:ma_laundry/utils/export_utils.dart';

import '../../../utils/navigator_helper.dart';
import '../../config/export_config.dart';

class DetailPembayaran extends StatefulWidget {
  final PembayaranData dataPembayaran;

  const DetailPembayaran({Key key, this.dataPembayaran}) : super(key: key);
  @override
  _DetailPembayaranState createState() => _DetailPembayaranState();
}

class _DetailPembayaranState extends State<DetailPembayaran> {
  PembayaranData get dataPembayaran => widget?.dataPembayaran;

  bool _showDetail = false;
  bool get showDetail => _showDetail;
  set showDetail(bool val) {
    setState(() => _showDetail = val);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: medium),
      width: widthScreen(context),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: normal),
        decoration: BoxDecoration(
          border: Border.all(color: greyColor, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(medium),
              decoration: BoxDecoration(
                  color: greyNeutral,
                  border: Border.all(color: greyColor, width: 1),
                  borderRadius: BorderRadius.circular(normal)),
              child: InkWell(
                onTap: () {
                  showDetail = !showDetail;
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Detail Pembayaran",
                      style: sansPro(),
                    ),
                    Icon(Icons.keyboard_arrow_down),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: showDetail,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: medium),
                child: (dataPembayaran?.pembayarans?.length ?? 0) == 0
                    ? notFoundDataStatus()
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: dataPembayaran.pembayarans.length,
                        itemBuilder: (BuildContext context, int index) {
                          Pembayaran data = dataPembayaran.pembayarans[index];
                          return ListTile(
                            leading: Image.network(
                              buktiPhotoUrl(
                                  dataPembayaran.laundry.kodeTransaksi,
                                  data.buktiBayar),
                              width: 50,
                              height: 50,
                              fit: BoxFit.fill,
                            ),
                            title: Column(
                              children: [
                                itemDetail2(
                                  title1: "Jumlah",
                                  title2: "Catatan",
                                  content1: formatMoney(data.jumlah),
                                  content2: data?.catatan ?? "",
                                ),
                                SizedBox(height: normal),
                                itemDetail2(
                                  title1: "Status",
                                  title2: "Tanggal/Jam",
                                  content1: data?.statusPersetujuan ?? "",
                                  content2: data?.tanggalPersetujuan ?? "-",
                                )
                              ],
                            ),
                            subtitle: Divider(thickness: 1),
                            onTap: () {
                              navigateTo(
                                  context,
                                  ZoomFoto(
                                    url: buktiPhotoUrl(
                                        dataPembayaran.laundry.kodeTransaksi,
                                        data.buktiBayar),
                                  ));
                            },
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  itemDetail2(
      {String title1, String title2, String content1, String content2}) {
    return Row(
      children: [
        Flexible(
          child: Container(
            width: widthScreen(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title1 ?? "n/a",
                    style: sansPro(fontSize: 14, fontWeight: FontWeight.w600)),
                Text(content1 ?? "n/a", style: sansPro(fontSize: 13)),
              ],
            ),
          ),
        ),
        SizedBox(width: medium),
        Flexible(
          child: Container(
            width: widthScreen(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title2 ?? "n/a",
                    style: sansPro(fontSize: 14, fontWeight: FontWeight.w600)),
                Text(content2 ?? "n/a", style: sansPro(fontSize: 13)),
              ],
            ),
          ),
        )
      ],
    );
  }
}
