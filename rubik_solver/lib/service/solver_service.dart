import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rubik_solver/screen/solve_screen.dart';
import 'package:rubik_solver/utils/constant.dart';
import 'package:rubik_solver/utils/widget/color_box.dart';
import 'package:rubik_solver/utils/widget/init_container.dart';

import 'data_service.dart';

class SolverService extends ChangeNotifier {
  BuildContext context;
  bool loading = false;

  SolverService(this.context);

  void _alertBox(DataService service, path, side) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
              insetPadding: EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              child: service.processing
                  ? Container(
                      margin: EdgeInsets.all(15),
                      height: 300.0,
                      width: 300.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        //  color: Colors.red,
                        image: DecorationImage(
                          image: FileImage(File(path)),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.black45),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SpinKitCubeGrid(
                              color: Colors.white,
                              size: 40.0,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text("Image Was Processing...",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white))
                          ],
                        ),
                      ))
                  : Container(
                      margin: EdgeInsets.all(15),
                      height: 300.0,
                      width: 300.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: service.error
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  service.errorText,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                FlatButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Try Again",
                                      style: TextStyle(color: Colors.blue),
                                    ))
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Colors are matched?",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                InitContainer(ColorBox(service.tempRGB), "",
                                    Colors.transparent),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Try Again",
                                          style: TextStyle(color: Colors.blue),
                                        )),
                                    FlatButton(
                                        onPressed: () {
                                          service.setsideColor(
                                              side, service.tempRGB);
                                          service.setsideColorCode(
                                              side, service.tempColorCode);
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Done",
                                          style: TextStyle(color: Colors.green),
                                        ))
                                  ],
                                )
                              ],
                            )));
        });
  }

  Future getImage(DataService service, String side) async {
    ImagePicker picker = ImagePicker();
    service.setProcessing(false);
    service.seterror(false);
    service.settempRGB([]);
    service.settempColorCode("");

    final pickedFile = await picker.getImage(
        source: ImageSource.camera, maxHeight: 1600, maxWidth: 1000);

    service.setProcessing(true);
    _alertBox(service, pickedFile.path, side);

    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(pickedFile.path,
          filename: "upload.jpeg"),
    });

    try {
      Response response = await Dio().post(baseUrl, data: formData);
      service.setProcessing(false);
      service.settempRGB(response.data["color_rgb"]);
      service.settempColorCode(response.data["color_name"]);

      if (response.data["status"] == false) {
        service.seterror(true);
        service.seterrorText("Unable to detect colors, try again...");
      }

      print(response.data);
    } catch (e) {
      service.setProcessing(false);
      service.seterror(true);
      service.seterrorText("Server Error");
    }
  }

  Widget checkSide(DataService service, String side) {
    return service.sideColor[side.toLowerCase()].length > 1
        ? ColorBox(service.sideColor[side])
        : getImageButton(service, side);
  }

  Widget getImageButton(DataService service, String side) {
    return InkWell(
      onTap: () {
        getImage(service, side);
      },
      child: Icon(
        Icons.add,
        size: 40,
      ),
    );
  }

  void solveCube(DataService service, _context) async {
    String _colorCode = service.sideColorCode["top"] +
        service.sideColorCode["left"] +
        service.sideColorCode["front"] +
        service.sideColorCode["right"] +
        service.sideColorCode["back"] +
        service.sideColorCode["bottom"];
    print(_colorCode);
    try {
      Response response =
          await Dio().get(baseUrl + "solve?colors=" + _colorCode);
      loading = false;
      notifyListeners();

      if (response.data["status"] == false) {
        Scaffold.of(_context).showSnackBar(new SnackBar(
          content: new Text('Wrong color pattern, Try again...'),
        ));
      } else {
        service.setrotations(response.data["rotations"]);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SolveScreen()));
      }
    } catch (e) {
      loading = false;
      notifyListeners();
      Scaffold.of(_context).showSnackBar(new SnackBar(
        content: new Text('Server error, Try again...'),
      ));
    }
  }
}
