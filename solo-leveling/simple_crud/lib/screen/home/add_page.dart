import 'package:flutter/material.dart';
import 'package:simple_crud/model/model_pegawai.dart';
import 'package:simple_crud/repository/pegawai_repo.dart';
import 'package:simple_crud/utils/custom_dialog.dart';

class AddPage extends StatefulWidget {
  final ModelPegawai dataPegawai;
  const AddPage({Key key, this.dataPegawai}) : super(key: key);
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  ModelPegawai data = ModelPegawai();

  void addData() async {
    progressDialog(context);
    await pegawaiRepo.addPegawai(data);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void updateData()async{
    progressDialog(context);
    // await pegawaiRepo.updatePegawai(data);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.dataPegawai != null) {
      data = widget.dataPegawai;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adding Page"),
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              initialValue: data?.nama ?? "",
              onChanged: (val) {
                setState(() => data?.nama = val);
              },
              decoration: InputDecoration(hintText: "Nama"),
            ),
            TextFormField(
              initialValue: data?.posisi ?? "",
              onChanged: (val) {
                setState(() => data?.posisi = val);
              },
              decoration: InputDecoration(hintText: "Posisi"),
            ),
            TextFormField(
              initialValue: data?.gaji ?? "",
              onChanged: (val) {
                setState(() => data?.gaji = val);
              },
              decoration: InputDecoration(hintText: "Gaji"),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              width: double.infinity,
              height: 45,
              child: RaisedButton(
                child: Text("Simpan"),
                onPressed: () {
                  if (widget.dataPegawai != null) {
                    //update
                  } else {
                    addData();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
