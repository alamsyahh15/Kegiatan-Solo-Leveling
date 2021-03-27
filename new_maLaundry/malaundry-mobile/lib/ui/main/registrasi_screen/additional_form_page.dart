import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ma_laundry/ui/bloc/registrasi_laundry_bloc/registrasi_bloc.dart';
import 'package:ma_laundry/ui/config/export_config.dart';
import 'package:ma_laundry/utils/image_taker.dart';

class AddtionalFormPage extends StatefulWidget {
  final RegistrasiBloc registrasiBloc;

  const AddtionalFormPage({Key key, this.registrasiBloc}) : super(key: key);

  @override
  _AddtionalFormPageState createState() => _AddtionalFormPageState();
}

class _AddtionalFormPageState extends State<AddtionalFormPage> {
  RegistrasiBloc get regBloc => widget.registrasiBloc;
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
                    "Tambahan",
                    style: sansPro(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                  SizedBox(height: high),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: normal),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Parfum",
                          style: sansPro(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: tiny),
                        borderDropdown(
                            child: Container(
                          padding: EdgeInsets.symmetric(horizontal: medium),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                                hint: Text("Pilih Parfum"),
                                isExpanded: true,
                                value: regBloc.valParfume,
                                items: regBloc.listParfume.map((e) {
                                  return DropdownMenuItem(
                                    value: e,
                                    child: Text("${e.labelParfum}"),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  setState(() {
                                    regBloc.valParfume = val;
                                  });
                                }),
                          ),
                        )),
                      ],
                    ),
                  ),
                  SizedBox(height: medium),
                  Container(
                    padding: EdgeInsets.all(normal),
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.black45,
                        ),
                        borderRadius: BorderRadius.circular(normal)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Tambahan",
                          style: sansPro(fontWeight: FontWeight.w600),
                        ),
                        Center(
                          child: Row(
                            children: [
                              Flexible(
                                child: CheckboxListTile(
                                  title: Text("Luntur", style: sansPro()),
                                  value: regBloc?.lunturVal,
                                  onChanged: (val) {
                                    regBloc?.lunturVal = val;
                                  },
                                ),
                              ),
                              Flexible(
                                child: CheckboxListTile(
                                  title: Text("Tas Kantong", style: sansPro()),
                                  value: regBloc?.tasKantongVal,
                                  onChanged: (val) {
                                    regBloc?.tasKantongVal = val;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextFormField(
                          initialValue: regBloc?.noteVal,
                          minLines: 1,
                          maxLines: 3,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: medium),
                            hintText: "Catatan...",
                          ),
                          onChanged: (val) {
                            regBloc?.noteVal = val;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: medium),
                  Text(
                    "Photo",
                    style: sansPro(fontWeight: FontWeight.w600),
                  ),
                  InkWell(
                    onTap: () async {
                      takeImage(context).then((res) {
                        if (res != null) {
                          regBloc?.photoAdditional = res;
                        }
                      });
                    },
                    child: Container(
                      width: widthScreen(context) / 2,
                      height: widthScreen(context) / 3,
                      child: regBloc?.photoAdditional != null
                          ? Image.file(regBloc.photoAdditional,
                              fit: BoxFit.fill)
                          : Icon(
                              Icons.cloud_upload,
                              size: high + medium,
                              color: whiteNeutral,
                            ),
                      decoration: BoxDecoration(
                          color: greyColor,
                          border: Border.all(color: greyColor),
                          borderRadius: BorderRadius.circular(normal)),
                    ),
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
