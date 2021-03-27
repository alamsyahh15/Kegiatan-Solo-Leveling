import 'package:flutter/material.dart';
import 'package:simple_crud/model/model_pegawai.dart';
import 'package:simple_crud/repository/pegawai_repo.dart';
import 'package:simple_crud/screen/home/add_page.dart';
import 'package:simple_crud/utils/constant.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ModelPegawai> listPegawai = [];
  var state = FETCH_STATE.STATE_READY;

  void getData() async {
    /// Pertama kali memanggil function
    setState(() => state = FETCH_STATE.STATE_LOADING);

    var result = await pegawaiRepo.getPegawai();

    /// Setelah seleseai Fetching Data Pegawai
    setState(() => state = FETCH_STATE.STATE_READY);
    if (result != null) {
      setState(() {
        listPegawai = result;
      });
    }
  }

  Future refresh() async {
    setState(() => listPegawai = []);
    getData();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple CRUD"),
      ),
      body: bodyHome(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          goTo(context, AddPage()).then((value) {
            refresh();
          });
        },
      ),

      //Optional 2
      // state == FETCH_STATE.STATE_LOADING
      //     ? Center(child: CircularProgressIndicator())
      //     : listPegawai.length == 0
      //         ? Center(child: Text("Data Kosong"))
      //         : ListView.builder(
      //             itemCount: listPegawai?.length ?? 0,
      //             itemBuilder: (BuildContext context, int index) {
      //               return Container(
      //                 margin: EdgeInsets.all(16),
      //                 child: Card(
      //                   elevation: 5,
      //                   child: Container(
      //                     width: double.infinity,
      //                     margin: EdgeInsets.all(16),
      //                     child: Column(
      //                       children: [Text("")],
      //                     ),
      //                   ),
      //                 ),
      //               );
      //             },
      //           ),
    );
  }

  /// Optional 1
  Widget bodyHome() {
    if (state == FETCH_STATE.STATE_LOADING) {
      return Center(child: CircularProgressIndicator());
    } else if (listPegawai.length == 0) {
      return Center(child: Text("Data Kosong"));
    } else {
      return RefreshIndicator(
        onRefresh: () async {
          await refresh();
          // return false;
        },
        child: ListView.builder(
          itemCount: listPegawai?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            ModelPegawai data = listPegawai[index];
            return InkWell(
              onTap: (){
                // Update
                goTo(context, AddPage(dataPegawai: data));
              },
              child: Dismissible(
                key: Key(data.nama),
                onDismissed: (DismissDirection direction) async {
                  if (direction == DismissDirection.endToStart) {
                    print("Data Update");
                  } else {
                    await pegawaiRepo.deletePegawai(data);
                    listPegawai.removeAt(index);
                  }
                },
                child: Container(
                  margin: EdgeInsets.all(16),
                  child: Card(
                    elevation: 5,
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(data?.nama ?? "-"),
                          Text(data?.gaji ?? "-"),
                          Text(data?.posisi ?? "-"),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
