import 'package:flutter/material.dart';
import 'package:ma_laundry/data/model/laundry_form_model.dart/service_satuan_model.dart';
import 'package:ma_laundry/ui/bloc/registrasi_laundry_bloc/registrasi_bloc.dart';
import 'package:ma_laundry/ui/config/export_config.dart';

import 'item_service.dart';

class ServiceSatuanPage extends StatefulWidget {
  final RegistrasiBloc registrasiBloc;

  const ServiceSatuanPage({Key key, this.registrasiBloc}) : super(key: key);
  @override
  _ServiceSatuanPageState createState() => _ServiceSatuanPageState();
}

class _ServiceSatuanPageState extends State<ServiceSatuanPage> {
  RegistrasiBloc get regBloc => widget?.registrasiBloc;

  List<bool> listShowItem = [];
  List<bool> listCheckItem = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List.generate(4, (index) {
      listShowItem.add(false);
      listCheckItem.add(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: normal, vertical: medium),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(normal)),
            elevation: 5,
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: medium, vertical: medium),
              width: widthScreen(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: normal),
                  Text(
                    "Service Satuan",
                    style: sansPro(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                  SizedBox(height: high),
                  regBloc.listUnit.length == 0
                      ? Container(
                          height: heightScreen(context) / 2,
                          alignment: Alignment.center,
                          child: Text(
                            "Pilih Konsumen",
                            style: sansPro(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        )
                      : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: regBloc.listUnit.length,
                          itemBuilder: (BuildContext context, int index) {
                            bool showItem = regBloc.listShowItemUnit[index];
                            DataSatuan dataSatuan = regBloc.listUnit[index];
                            return ItemService(
                              dataSatuan: dataSatuan,
                              regBloc: regBloc,
                              index: index,
                              showItem: showItem,
                            );
                          },
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
