import 'package:flutter/material.dart';
import 'package:ma_laundry/data/model/pengeluaran_model/item_model.dart';
import 'package:ma_laundry/data/model/pengeluaran_model/pengeluaran_model.dart';
import 'package:provider/provider.dart';
import '../../../utils/export_utils.dart';
import '../../bloc/pengeluaran_bloc/pengeluaran_bloc.dart';
import '../../config/colors.dart';
import '../../config/export_config.dart';
import '../../config/fonts_local.dart';
import '../../config/spacing.dart';
import '../../config/widget.dart';

class FormPengeluaranPage extends StatefulWidget {
  final TabController tabController;

  const FormPengeluaranPage({Key key, this.tabController}) : super(key: key);
  @override
  _FormPengeluaranPageState createState() => _FormPengeluaranPageState();
}

class _FormPengeluaranPageState extends State<FormPengeluaranPage> {
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => PengeluaranBloc.initForm(context, key: key))
      ],
      child: Consumer<PengeluaranBloc>(
        builder: (context, pengeluaranBloc, _) => Scaffold(
          key: key,
          body: pengeluaranBloc.isLoading
              ? circularProgressIndicator()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: medium, vertical: normal),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(normal)),
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.all(medium),
                            width: widthScreen(context),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Pengeluaran Form",
                                  style: sansPro(
                                    fontWeight: FontWeight.w600,
                                    fontSize: medium,
                                  ),
                                ),
                                SizedBox(height: medium),
                                Text("Item",
                                    style:
                                        sansPro(fontWeight: FontWeight.w600)),
                                borderDropdown(
                                  child: DropdownButtonHideUnderline(
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: medium),
                                      child: DropdownButton(
                                        isExpanded: true,
                                        hint: Text("Pilih Item"),
                                        value: pengeluaranBloc.itemValue,
                                        items:
                                            pengeluaranBloc.listItem.map((e) {
                                          return DropdownMenuItem(
                                            child: Text("${e.item}"),
                                            value: e,
                                          );
                                        }).toList(),
                                        onChanged: (DataItem value) {
                                          if (value != null) {
                                            setState(() {
                                              pengeluaranBloc.itemValue = value;
                                              pengeluaranBloc.dataCreate
                                                  .kategori = value.item;
                                              pengeluaranBloc.dataCreate
                                                  .idItem = value.idItem;
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: medium),
                                Visibility(
                                  visible:
                                      pengeluaranBloc.itemValue?.kategori !=
                                          "TARIKAN",
                                  child: Text("Satuan Unit",
                                      style:
                                          sansPro(fontWeight: FontWeight.w600)),
                                ),
                                Visibility(
                                  visible:
                                      pengeluaranBloc.itemValue?.kategori !=
                                          "TARIKAN",
                                  child: borderDropdown(
                                    child: DropdownButtonHideUnderline(
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: medium),
                                        child: DropdownButton(
                                          isExpanded: true,
                                          hint: Text("Pilih Satuan unit"),
                                          value: pengeluaranBloc
                                              .dataCreate?.satuanUnit,
                                          items: SATUAN_UNIT.map((e) {
                                            return DropdownMenuItem(
                                              child: Text("$e"),
                                              value: e,
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              pengeluaranBloc.dataCreate
                                                  ?.satuanUnit = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                    visible:
                                        pengeluaranBloc.itemValue?.kategori !=
                                            "TARIKAN",
                                    child: SizedBox(height: medium)),
                                Visibility(
                                  visible:
                                      pengeluaranBloc.itemValue?.kategori !=
                                          "TARIKAN",
                                  child: pengeluaranBloc.isSubmit
                                      ? disableTextField()
                                      : CustomTextField(
                                          label: "Jumlah",
                                          keyboardType: TextInputType.number,
                                          onChanged: (val) {
                                            setState(() {
                                              pengeluaranBloc
                                                  .dataCreate?.jumlah = val;
                                            });
                                          },
                                        ),
                                ),
                                Visibility(
                                    visible:
                                        pengeluaranBloc.itemValue?.kategori !=
                                            "TARIKAN",
                                    child: SizedBox(height: medium)),
                                pengeluaranBloc.isSubmit
                                    ? disableTextField()
                                    : CustomTextField(
                                        label: "Harga",
                                        keyboardType: TextInputType.number,
                                        onChanged: (val) {
                                          setState(() {
                                            pengeluaranBloc
                                                .dataCreate?.totalHarga = val;
                                          });
                                        },
                                      ),
                                SizedBox(height: medium),
                                pengeluaranBloc.isSubmit
                                    ? disableTextField()
                                    : CustomTextField(
                                        label: "Catatan",
                                        minLines: 3,
                                        maxLines: 10,
                                        onChanged: (val) {
                                          setState(() {
                                            pengeluaranBloc
                                                .dataCreate?.catatan = val;
                                          });
                                        },
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          bottomNavigationBar: BottomAppBar(
            child: Container(
                margin:
                    EdgeInsets.symmetric(horizontal: medium, vertical: normal),
                child: Row(
                  children: [
                    Flexible(
                      child: Container(
                        height: 45,
                        width: widthScreen(context),
                        // ignore: deprecated_member_use
                        child: OutlineButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(normal)),
                          borderSide: BorderSide(color: primaryColor),
                          textColor: primaryColor,
                          child: Text("Back"),
                          onPressed: () {
                            setState(() {
                              widget.tabController.index = 0;
                            });
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
                          child: Text("Submit"),
                          onPressed: () {
                            pengeluaranBloc
                                .createPengeluaran(widget.tabController)
                                .then((value) {
                              setState(() {
                                pengeluaranBloc.itemValue = null;
                                pengeluaranBloc.dataCreate = DataPengeluaran();
                              });
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
