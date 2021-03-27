import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ma_laundry/data/model/laundry_form_model.dart/consumer_model.dart';
import 'package:ma_laundry/data/network/network_export.dart';
import 'package:ma_laundry/data/network/repository/laundry_form_repository/registrasi_form_repo.dart';
import 'package:ma_laundry/ui/bloc/konsumen_bloc/konsumen_bloc.dart';
import 'package:ma_laundry/ui/bloc/registrasi_laundry_bloc/registrasi_bloc.dart';
import 'package:ma_laundry/ui/config/export_config.dart';
import 'package:ma_laundry/utils/export_utils.dart';
import 'package:provider/provider.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class LaundryFormPage extends StatefulWidget {
  final RegistrasiBloc registrasiBloc;
  const LaundryFormPage({Key key, this.registrasiBloc}) : super(key: key);

  @override
  _LaundryFormPageState createState() => _LaundryFormPageState();
}

class _LaundryFormPageState extends State<LaundryFormPage> {
  RegistrasiBloc get regBloc => widget.registrasiBloc;
  Image image;

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
                    "Laundry Form",
                    style: sansPro(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                  SizedBox(height: high),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: normal),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Konsumen",
                          style: sansPro(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: tiny),
                        Row(
                          children: [
                            Flexible(
                              child: borderDropdown(
                                child: SearchableDropdown<DataConsumer>(
                                  isExpanded: true,
                                  underline: NotGiven(),
                                  icon: Icon(Icons.search),
                                  isCaseSensitiveSearch: false,
                                  value: regBloc.valDataConsumer,
                                  items: regBloc.listConsumer.map((e) {
                                    return DropdownMenuItem<DataConsumer>(
                                      child: Text(
                                        "${e?.namaDepan} ${e?.namaBelakang}",
                                        maxLines: 2,
                                      ),
                                      value: e,
                                    );
                                  }).toList(),
                                  onChanged: (DataConsumer value) {
                                    setState(() {
                                      regBloc?.valDataConsumer = value;
                                      if (value != null) {
                                        regBloc.initService();
                                      }
                                    });
                                  },
                                  hint: Text("Select Konsumen"),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: normal),
                              width: 60,
                              height: 45,
                              // ignore: deprecated_member_use
                              child: RaisedButton(
                                color: primaryColor,
                                child: Icon(
                                  Icons.person_add,
                                  color: whiteNeutral,
                                ),
                                onPressed: () {
                                  showAsBottomSheet();
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: medium),
                  CustomTextField(
                    readOnly: true,
                    label: "Nomor Handphone",
                    hint: regBloc?.valDataConsumer?.telp ?? "",
                    onChanged: (value) {},
                  ),
                  SizedBox(height: medium),
                  CustomTextField(
                    readOnly: true,
                    label: "Alamat",
                    hint: regBloc?.valDataConsumer?.alamat ?? "",
                    minLines: 3,
                    maxLines: 6,
                    onChanged: (value) {},
                  ),
                  SizedBox(height: medium),
                  Text(
                    "Pakai Kuota",
                    style: sansPro(fontWeight: FontWeight.w600),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: USED_QUOTA
                        .map((e) => Flexible(
                              child: RadioListTile(
                                title: Text("$e"),
                                groupValue: regBloc?.valDataConsumer?.isKuota,
                                value: e,
                                onChanged: (value) {
                                  setState(() {
                                    regBloc?.resetData();
                                    regBloc?.valDataConsumer?.isKuota = value;
                                    regBloc.countSisaTagihan();
                                  });
                                },
                              ),
                            ))
                        .toList(),
                  ),
                  SizedBox(height: medium),
                  Visibility(
                    visible:
                        (regBloc?.valDataConsumer?.isKuota ?? "YA") == "YA",
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          readOnly: true,
                          label: "Sisa Kuota Setrika",
                          hint: regBloc?.valDataConsumer?.kuotaSetrika ?? "",
                          onChanged: (value) {},
                        ),
                        SizedBox(height: medium),
                        CustomTextField(
                          readOnly: true,
                          label: "Sisa Kuota Cuci Komplit",
                          hint: regBloc?.valDataConsumer?.kuotaCuci ?? "",
                          onChanged: (value) {},
                        ),
                        SizedBox(height: medium),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future showAsBottomSheet() async {
    DataConsumer dataRes;
    await showSlidingBottomSheet(context, builder: (context) {
      return SlidingSheetDialog(
        elevation: 8,
        cornerRadius: 16,
        snapSpec: const SnapSpec(
          snap: true,
          snappings: [0.9, 0.4],
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        duration: Duration(milliseconds: 800),
        scrollSpec: ScrollSpec.bouncingScroll(),
        cornerRadiusOnFullscreen: 8,
        headerBuilder: (context, state) {
          return Material(
            child: Container(
              width: widthScreen(context),
              margin: EdgeInsets.all(medium),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: widthScreen(context),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.drag_handle,
                      size: 35,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    "Register Form",
                    style: sansPro(
                        fontSize: medium + normal, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          );
        },
        builder: (context, state) {
          return SlidingSheetConsumer(
            onClosed: (val) async {
              progressDialog(context);
              await regBloc.getSearchConsumer();
              regBloc.initService();
              Navigator.pop(context);
              setState(() {
                List<DataConsumer> listTemp = regBloc?.listConsumer
                    ?.where((e) => e.idKonsumen == val.idKonsumen)
                    ?.toList();
                if ((listTemp?.length ?? 0) > 0) {
                  regBloc?.valDataConsumer = listTemp[0];
                }
                log("Data ${regBloc?.valDataConsumer?.toJson()}");
              });
            },
          );
        },
      );
    }); // This is the result.
    if (dataRes != null) {
      regBloc?.valDataConsumer = dataRes;
    }
  }
}

class SlidingSheetConsumer extends StatefulWidget {
  final Function(DataConsumer value) onClosed;
  final DataConsumer dataUpdate;
  SlidingSheetConsumer({
    Key key,
    this.onClosed,
    this.dataUpdate,
  }) : super(key: key);
  @override
  _SlidingSheetConsumerState createState() => _SlidingSheetConsumerState();
}

class _SlidingSheetConsumerState extends State<SlidingSheetConsumer> {
  DataConsumer dataCons = DataConsumer();
  DataConsumer get dataUpdate => widget?.dataUpdate;
  TextEditingController username = TextEditingController();
  File file;
  bool validate() {
    bool valid = true;
    if (dataCons.title == null || dataCons.title.isEmpty) {
      valid = false;
    }
    if (dataCons.namaDepan == null || dataCons.namaDepan.isEmpty) {
      valid = false;
    }
    if (dataCons.namaBelakang == null || dataCons.namaBelakang.isEmpty) {
      valid = false;
    }
    if (dataCons.username == null || dataCons.username.isEmpty) {
      valid = false;
    }
    if (dataCons.kode == null || dataCons.kode.isEmpty) {
      valid = false;
    }
    return valid;
  }

  initUpdate() {
    if (dataUpdate != null) {
      setState(() {
        dataCons = widget?.dataUpdate;
        if (dataCons?.telp != null) {
          dataCons.telp = dataCons.telp.replaceFirst("62", "");
        }
        username.text = dataCons.username;
        dataCons.kode = widget.dataUpdate.user.pin;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (conetext) => KonsumenBloc.initUpdate(context))
        ],
        child: Consumer<KonsumenBloc>(
          builder: (context, konsumenBloc, _) => Container(
            padding: EdgeInsets.only(top: high + normal),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: medium),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Photo",
                              style: sansPro(fontWeight: FontWeight.w600),
                            ),
                            InkWell(
                              onTap: () async {
                                var res = await takeImage(context);
                                if (res != null) {
                                  setState(() {
                                    file = res;
                                  });
                                }
                              },
                              child: Container(
                                width: 200,
                                height: 100,
                                child: dataUpdate != null
                                    ? file != null
                                        ? Image.file(file, fit: BoxFit.fill)
                                        : Image.network(
                                            photoConsumerUrl(
                                                dataCons?.kode, dataCons?.foto),
                                            fit: BoxFit.fill)
                                    : file != null
                                        ? Image.file(file, fit: BoxFit.fill)
                                        : Icon(
                                            Icons.cloud_upload,
                                            color: whiteNeutral,
                                            size: 45,
                                          ),
                                decoration: BoxDecoration(
                                  color: greyColor.withOpacity(0.5),
                                  border: Border.all(color: greyColor),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            SizedBox(height: medium),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Title",
                                  style: sansPro(fontWeight: FontWeight.w600),
                                ),
                                Visibility(
                                  visible: dataCons.title == null,
                                  child: Text(
                                    "Form Wajib Diisi",
                                    style: sansPro(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                            borderDropdown(
                              autovalidate: true,
                              value: dataCons.title,
                              child: Container(
                                margin:
                                    EdgeInsets.symmetric(horizontal: normal),
                                child: DropdownButtonHideUnderline(
                                  child: Container(
                                    child: DropdownButton(
                                      hint: Text("Pilih Title"),
                                      isExpanded: true,
                                      value: dataCons?.title,
                                      items: TITLE_CUSTOMER.map((e) {
                                        return DropdownMenuItem(
                                          child: Text("$e"),
                                          value: e,
                                        );
                                      }).toList(),
                                      onChanged: (val) {
                                        setState(() {
                                          dataCons.title = val;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: medium),
                            CustomTextField(
                              label: "Nama Depan",
                              autoValidate: true,
                              initialValue: dataCons?.namaDepan ?? "",
                              onChanged: (val) {
                                setState(() {
                                  dataCons?.namaDepan = val;
                                  username.text = "";
                                  if (val.isNotEmpty) {
                                    username.text =
                                        (dataCons?.namaDepan ?? "") +
                                            (dataCons?.namaBelakang ?? "");
                                  }
                                });
                              },
                            ),
                            SizedBox(height: medium),
                            CustomTextField(
                              label: "Nama Belakang",
                              autoValidate: true,
                              initialValue: dataCons?.namaBelakang ?? "",
                              onChanged: (val) {
                                setState(() {
                                  dataCons?.namaBelakang = val;
                                  username.text = "";
                                  if (val.isNotEmpty) {
                                    username.text =
                                        (dataCons?.namaDepan ?? "") +
                                            (dataCons?.namaBelakang ?? "");
                                  }
                                });
                              },
                            ),
                            SizedBox(height: medium),
                            CustomTextField(
                              keyboardType: TextInputType.number,
                              label: "Nomor Hand Phone",
                              showCodeDefaultNum: true,
                              initialValue: dataCons?.telp ?? "",
                              onChanged: (val) {
                                setState(() {
                                  dataCons?.telp = "62$val";
                                });
                              },
                            ),
                            SizedBox(height: medium),
                            CustomTextField(
                              autoValidate: true,
                              label: "Username",
                              controller: username,
                            ),
                            SizedBox(height: medium),
                            CustomTextField(
                              obscureText: false,
                              label: "PIN",
                              autoValidate: true,
                              keyboardType: TextInputType.number,
                              initialValue: dataCons?.kode ?? "",
                              onChanged: (val) {
                                setState(() {
                                  dataCons?.kode = val;
                                });
                              },
                            ),
                            SizedBox(height: medium),
                            CustomTextField(
                              label: "Alamat",
                              minLines: 3,
                              maxLines: 8,
                              initialValue: dataCons?.alamat ?? "",
                              onChanged: (val) {
                                setState(() => dataCons?.alamat = val);
                              },
                            ),
                            SizedBox(height: medium),
                            Row(
                              children: [
                                Flexible(
                                  child: Container(
                                    height: 45,
                                    width: widthScreen(context),
                                    // ignore: deprecated_member_use
                                    child: OutlineButton(
                                      textColor: primaryColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(normal)),
                                      borderSide:
                                          BorderSide(color: primaryColor),
                                      child: Text("Back"),
                                      onPressed: () {
                                        Navigator.pop(context);
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
                                          borderRadius:
                                              BorderRadius.circular(normal)),
                                      color: primaryColor,
                                      textColor: whiteNeutral,
                                      child: Text(dataUpdate != null
                                          ? "Update"
                                          : "Submit"),
                                      onPressed: () async {
                                        dataCons.username = username.text;
                                        var res;
                                        if (dataCons.telp.startsWith("62")) {
                                          dataCons.telp = dataCons.telp
                                              .replaceFirst("62", "");
                                        }

                                        dataCons?.telp = "62${dataCons.telp}";
                                        if (validate() == true) {
                                          progressDialog(context);
                                          if (widget?.dataUpdate != null) {
                                            log("Update Konsumen");
                                            res = await konsumenBloc
                                                .updateKonsumen(dataCons, file);
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            DataConsumer res1 = DataConsumer();
                                            widget.onClosed(res1);
                                          } else {
                                            log("Add Konsumen");
                                            res = await registrasiFormRepo
                                                .createConsumer(dataCons, file);
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            if (res is! String) {
                                              DataConsumer dataConsum =
                                                  DataConsumer(
                                                idKonsumen:
                                                    res?.idKonsumen ?? null,
                                              );
                                              widget.onClosed(dataConsum);
                                            }
                                          }
                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                    title:
                                                        Text("Information!!"),
                                                    content: Text(
                                                        "Harap check kembali field yang diisi"),
                                                    actions: [
                                                      Container(
                                                        height: 45,
                                                        // ignore: deprecated_member_use
                                                        child: RaisedButton(
                                                            child: Text("Back"),
                                                            textColor:
                                                                whiteNeutral,
                                                            color: Colors.red,
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            }),
                                                      )
                                                    ],
                                                  ));
                                        }
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: medium),
                          ],
                        ),
                      ),
                    ],
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
