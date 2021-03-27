import 'package:flutter/material.dart';
import 'package:ma_laundry/ui/bloc/registrasi_laundry_bloc/registrasi_bloc.dart';
import 'package:ma_laundry/ui/config/export_config.dart';
import 'package:ma_laundry/ui/main/registrasi_screen/item_service.dart';

class ServiceKilosPage extends StatefulWidget {
  final RegistrasiBloc registrasiBloc;

  const ServiceKilosPage({Key key, this.registrasiBloc}) : super(key: key);

  @override
  _ServiceKilosPageState createState() => _ServiceKilosPageState();
}

class _ServiceKilosPageState extends State<ServiceKilosPage> {
  RegistrasiBloc get regBloc => widget?.registrasiBloc;

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
                    "Service Kiloan",
                    style: sansPro(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                  SizedBox(height: high),
                  regBloc.listKilos.length == 0
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
                          itemCount: regBloc.listKilos.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ItemService(
                              regBloc: regBloc,
                              index: index,
                              dataKiloan: regBloc.listKilos[index],
                              showItem: regBloc.listShowItemKilos[index],
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
