import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mentoringmasalam2/models/user_model.dart';
import 'package:mentoringmasalam2/repository/user_repository.dart';
import 'listUmur.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User> listUser = [], listBackup = [];

  /// Revisi Simple filter
  ///
  /// Note Implementasikan Metode Search Sebelumnya
  filterByAge(String inputQuery) {
    listBackup = listUser;
    if (inputQuery.isNotEmpty || inputQuery != null) {
      listBackup = listBackup.where((e) => e.age == inputQuery).toList();
    }
    setState(() {});
  }

  //method initial akan dipanggil pertama kali membuka screen homepage
  void initial() async {
    //Memanggl function get data user dan memasukkan ke dalam variabel
    List<User> result = await userRepo.getDataUser();
    if (result != null) {
      setState(() {
        //Set result yang di dapat ke dalam variabel listuser diatas
        listUser = result;
        listBackup = result;

        log("User ${jsonEncode(result.toList())}");
      });
    }
  }

  void search(String inputQuery) {
    if (inputQuery.isEmpty) {
      // listUser = listBackup;
      listBackup = listUser;
    } else {
      String query = inputQuery.toLowerCase();
      // listUser = listUser
      listBackup = listUser
          .where((element) => element.name.toLowerCase().contains(query))
          .toList();
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple CRUD"),
        backgroundColor: Colors.red,
        actions: <Widget>[
          Builder(
              builder: (context) => IconButton(
                    icon: Icon(Icons.dehaze_outlined),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text("Cari berdasarkan umur :"),
                                SizedBox(
                                  height: 20,
                                ),
                                RaisedButton(
                                  child: Text('19'),
                                  color: Colors.red,
                                  onPressed: () {
                                    Navigator.pop(context);
                                    filterByAge("19");
                                    // Navigator.push(context, MaterialPageRoute(
                                    //     builder: (BuildContext context) {
                                    //   return ListUmur(
                                    //     age: 19,
                                    //   );
                                    // }));
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                RaisedButton(
                                  child: Text('20'),
                                  color: Colors.blue,
                                  onPressed: () {
                                    Navigator.pop(context);
                                    filterByAge("20");
                                    // Navigator.push(context, MaterialPageRoute(
                                    //     builder: (BuildContext context) {
                                    //   return ListUmur(
                                    //     age: 20,
                                    //   );
                                    // }));
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                RaisedButton(
                                  child: Text('21'),
                                  color: Colors.yellow,
                                  onPressed: () {
                                    Navigator.pop(context);
                                    filterByAge("21");
                                    // Navigator.push(context, MaterialPageRoute(
                                    //     builder: (BuildContext context) {
                                    //   return ListUmur(
                                    //     age: 21,
                                    //   );
                                    // }));
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                RaisedButton(
                                  child: Text('22'),
                                  color: Colors.green,
                                  onPressed: () {
                                    Navigator.pop(context);
                                    filterByAge("22");
                                    // Navigator.push(context, MaterialPageRoute(
                                    //     builder: (BuildContext context) {
                                    //   return ListUmur(
                                    //     age: 22,
                                    //   );
                                    // }));
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                RaisedButton(
                                  child: Text('23'),
                                  color: Colors.orange,
                                  onPressed: () {
                                    Navigator.pop(context);
                                    filterByAge("23");
                                    // Navigator.push(context, MaterialPageRoute(
                                    //     builder: (BuildContext context) {
                                    //   return ListUmur(
                                    //     age: 23,
                                    //   );
                                    // }));
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ))
        ],
      ),
      body: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              hintText: "Masukkan Namamu",
              icon: Icon(Icons.search),
            ),
            onChanged: (value) {
              search(value);
            },
          ),
          SizedBox(
            height: 16,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              child: ListView.builder(
                itemCount: listBackup.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 16,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text("Nama :${listBackup[index].name}"),
                          Text("Umur :${listBackup[index].age}"),
                          Text("Pekerjaan :${listBackup[index].jobs}"),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  // void _filterByCategory() {
  //   builder:
  //   (context) => BottomSheet(
  //         builder: (BuildContext context) {
  //           return Container(
  //             child: Column(
  //               children: [
  //                 _buildBottomNavigationMenu(),
  //               ],
  //             ),
  //           );
  //         },
  //         onClosing: (){},
  //       ),
  //       context: context,
  // }

  // void _filterByCategory() {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (context) {
  //         return Container(
  //           color: Color(0xFF737373),
  //           height: 350,
  //           child: Container(
  //             child: _buildBottomNavigationMenu(),
  //             decoration: BoxDecoration(
  //               color: Theme.of(context).canvasColor,
  //               borderRadius: BorderRadius.only(
  //                 topLeft: const Radius.circular(10),
  //                 topRight: const Radius.circular(10),
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //       );
  // }

//   Column _buildBottomNavigationMenu() {
//     return Column(
//       children: <Widget>[
//         Padding(
//           padding: EdgeInsets.all(10),
//         ),
//         Text("Cari Berdasarkan Umur : "),
//         SizedBox(
//           height: 10,
//         ),
//         RaisedButton(
//           child: Text('19'),
//           color: Colors.red,
//           onPressed: () {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (BuildContext context) {
//               return ListUmur(
//                 age: 19,
//               );
//             }));
//           },
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         RaisedButton(
//           child: Text('20'),
//           color: Colors.blue,
//           onPressed: () {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (BuildContext context) {
//               return ListUmur(
//                 age: 20,
//               );
//             }));
//           },
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         RaisedButton(
//           child: Text('21'),
//           color: Colors.yellow,
//           onPressed: () {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (BuildContext context) {
//               return ListUmur(
//                 age: 21,
//               );
//             }));
//           },
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         RaisedButton(
//           child: Text('22'),
//           color: Colors.green,
//           onPressed: () {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (BuildContext context) {
//               return ListUmur(
//                 age: 22,
//               );
//             }));
//           },
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         RaisedButton(
//           child: Text('23'),
//           color: Colors.orange,
//           onPressed: () {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (BuildContext context) {
//               return ListUmur(
//                 age: 23,
//               );
//             }));
//           },
//         ),
//       ],
//     );
//   }
// }
}
