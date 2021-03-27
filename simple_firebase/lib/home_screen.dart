import 'package:flutter/material.dart';
import 'package:simple_firebase/detail_post.dart';
import 'package:simple_firebase/network_repository.dart';
import 'package:simple_firebase/post_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  List<PostModel> listDataPost = [];

  void inititalData() async {
    /// Memunculkan loading bar
    setState(() => isLoading = true);

    /// Memasukan hasil return dari repository kedalam variable result
    final result = await networkRepo.getData();

    setState(() {
      /// Setelah selesai inisiasi atau menjalankan repository hilangkan loading
      isLoading = false;

      /// Memasukan data dari result kedalam variabel listData
      if (result != null) {
        listDataPost = result;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inititalData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Data"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : listDataPost.length == 0
              ? Center(child: Text('Data Kosong'))
              : ListView.builder(itemBuilder: (context, index) {
                  PostModel data = listDataPost[index];
                  return InkWell(
                    onTap: () async {
                      /// Tampilkan dialog progress
                      progressDialog(context);

                      /// Sebelum getDetailData selesai dijalankan maka dialog progesss tidak akan ditutup
                      final result = await networkRepo.getDetailData(data.id);

                      /// Menutup dialog Progress
                      Navigator.pop(context);

                      /// Jika Result tidak null maka pindah kedalam page detail
                      if (result != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailPost(data: data)),
                        );
                      }
                    },
                    child: Container(
                      child: Card(
                        child: Container(
                          margin: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${data?.id}"),
                              SizedBox(height: 16),
                              Text(
                                "${data?.title}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(height: 16),
                              Text("${data?.body}"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
    );
  }
}

progressDialog(BuildContext context) {
  showGeneralDialog(
      barrierDismissible: false,
      barrierColor: Colors.black45.withOpacity(0.65),
      context: context,
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, animation1, animation2) => Center(
            child: CircularProgressIndicator(),
          ));
}
