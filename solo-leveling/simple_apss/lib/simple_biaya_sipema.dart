import 'dart:developer';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SimpleBiayaSipema extends StatefulWidget {
  @override
  _SimpleBiayaSipemaState createState() => _SimpleBiayaSipemaState();
}

class _SimpleBiayaSipemaState extends State<SimpleBiayaSipema> {
  /// Taruh fungsi ini di repository
  Future getBiayaSipema() async {
    try {
      final response = await http
          .post(Uri.parse("https://dev-api.edunitas.com/biayasipema"));
      if (response.statusCode == 200) {
        return SimpemaModel.fromJson(jsonDecode(response.body)).sipema;
      }
    } catch (e) {
      log("Exception $e");
      return null;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Biaya Sipema"),
      ),
      body: FutureBuilder(
          future: getBiayaSipema(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            } else {
              Map<String, Map<String, Sipema>> data = snapshot.data;
              List<Map<String, Sipema>> list =
                  data.entries.map((e) => e.value).toList();
              List<Iterable<Sipema>> finalList =
                  list.map((e) => e.values).toList();
              final lastList =
                  finalList.map((e) => e.map((e) => e).toList()).toList();
              List<List<Sipema>> dataSipema = lastList.map((e) => e).toList();

              return Container(
                child: ListView.builder(
                  itemCount: dataSipema.length,
                  itemBuilder: (BuildContext context, int index) {
                    List<Sipema> lastDataSipema = dataSipema[index];
                    return Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: lastDataSipema.length,
                          itemBuilder: (BuildContext context, int index) {
                            Sipema datSipemaByIndex = lastDataSipema[index];
                            return Container(
                              child: Column(
                                children: [
                                  Text(
                                      "Hallo Sipema Bulan ${datSipemaByIndex.detail.jurusan}"),
                                  Text(
                                      "Hallo Sipema Angsur${datSipemaByIndex.angsur.spb.angs1.angs1}"),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              );
            }
          }),
    );
  }
}

/*
 * Taruh didalam kelas model
 */

SimpemaModel simpemaModelFromJson(String str) =>
    SimpemaModel.fromJson(json.decode(str));

String simpemaModelToJson(SimpemaModel data) => json.encode(data.toJson());

class SimpemaModel {
  SimpemaModel({
    this.status,
    this.message,
    this.sipema,
  });

  int status;
  String message;
  Map<String, Map<String, Sipema>> sipema;

  factory SimpemaModel.fromJson(Map<String, dynamic> json) => SimpemaModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        sipema: json["sipema"] == null
            ? null
            : Map.from(json["sipema"]).map((k, v) =>
                MapEntry<String, Map<String, Sipema>>(
                    k,
                    Map.from(v).map((k, v) =>
                        MapEntry<String, Sipema>(k, Sipema.fromJson(v))))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "sipema": sipema == null
            ? null
            : Map.from(sipema).map((k, v) => MapEntry<String, dynamic>(
                k,
                Map.from(v)
                    .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())))),
      };
}

class Sipema {
  Sipema({
    this.detail,
    this.itembayar,
    this.angsur,
    this.bulanan,
  });

  Detail detail;
  Itembayar itembayar;
  Angsur angsur;
  String bulanan;

  factory Sipema.fromJson(Map<String, dynamic> json) => Sipema(
        detail: json["detail"] == null ? null : Detail.fromJson(json["detail"]),
        itembayar: json["itembayar"] == null
            ? null
            : Itembayar.fromJson(json["itembayar"]),
        angsur: json["angsur"] == null ? null : Angsur.fromJson(json["angsur"]),
        bulanan: json["bulanan"] == null ? null : json["bulanan"],
      );

  Map<String, dynamic> toJson() => {
        "detail": detail == null ? null : detail.toJson(),
        "itembayar": itembayar == null ? null : itembayar.toJson(),
        "angsur": angsur == null ? null : angsur.toJson(),
        "bulanan": bulanan == null ? null : bulanan,
      };
}

class Angsur {
  Angsur({
    this.spb,
    this.spp,
  });

  Spb spb;
  Spp spp;

  factory Angsur.fromJson(Map<String, dynamic> json) => Angsur(
        spb: json["spb"] == null ? null : Spb.fromJson(json["spb"]),
        spp: json["spp"] == null ? null : Spp.fromJson(json["spp"]),
      );

  Map<String, dynamic> toJson() => {
        "spb": spb == null ? null : spb.toJson(),
        "spp": spp == null ? null : spp.toJson(),
      };
}

class Spb {
  Spb({
    this.angs12,
    this.angs7,
    this.angs4,
    this.angs1,
    this.angs24,
  });

  Map<String, int> angs12;
  Angs7 angs7;
  Angs angs4;
  Angs1 angs1;
  Map<String, int> angs24;

  factory Spb.fromJson(Map<String, dynamic> json) => Spb(
        angs12: json["angs12"] == null
            ? null
            : Map.from(json["angs12"])
                .map((k, v) => MapEntry<String, int>(k, v)),
        angs7: json["angs7"] == null ? null : Angs7.fromJson(json["angs7"]),
        angs4: json["angs4"] == null ? null : Angs.fromJson(json["angs4"]),
        angs1: json["angs1"] == null ? null : Angs1.fromJson(json["angs1"]),
        angs24: json["angs24"] == null
            ? null
            : Map.from(json["angs24"])
                .map((k, v) => MapEntry<String, int>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "angs12": angs12 == null
            ? null
            : Map.from(angs12).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "angs7": angs7 == null ? null : angs7.toJson(),
        "angs4": angs4 == null ? null : angs4.toJson(),
        "angs1": angs1 == null ? null : angs1.toJson(),
        "angs24": angs24 == null
            ? null
            : Map.from(angs24).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}

class Angs1 {
  Angs1({
    this.angs1,
  });

  int angs1;

  factory Angs1.fromJson(Map<String, dynamic> json) => Angs1(
        angs1: json["angs1"] == null ? null : json["angs1"],
      );

  Map<String, dynamic> toJson() => {
        "angs1": angs1 == null ? null : angs1,
      };
}

class Angs {
  Angs({
    this.angs4,
    this.angs3,
    this.angs2,
    this.angs1,
    this.angs5,
    this.angs6,
  });

  int angs4;
  int angs3;
  int angs2;
  int angs1;
  int angs5;
  int angs6;

  factory Angs.fromJson(Map<String, dynamic> json) => Angs(
        angs4: json["angs4"] == null ? null : json["angs4"],
        angs3: json["angs3"] == null ? null : json["angs3"],
        angs2: json["angs2"] == null ? null : json["angs2"],
        angs1: json["angs1"] == null ? null : json["angs1"],
        angs5: json["angs5"] == null ? null : json["angs5"],
        angs6: json["angs6"] == null ? null : json["angs6"],
      );

  Map<String, dynamic> toJson() => {
        "angs4": angs4 == null ? null : angs4,
        "angs3": angs3 == null ? null : angs3,
        "angs2": angs2 == null ? null : angs2,
        "angs1": angs1 == null ? null : angs1,
        "angs5": angs5 == null ? null : angs5,
        "angs6": angs6 == null ? null : angs6,
      };
}

class Angs7 {
  Angs7({
    this.angs7,
    this.angs6,
    this.angs5,
    this.angs4,
    this.angs3,
    this.angs2,
    this.angs1,
  });

  int angs7;
  int angs6;
  int angs5;
  int angs4;
  int angs3;
  int angs2;
  int angs1;

  factory Angs7.fromJson(Map<String, dynamic> json) => Angs7(
        angs7: json["angs7"] == null ? null : json["angs7"],
        angs6: json["angs6"] == null ? null : json["angs6"],
        angs5: json["angs5"] == null ? null : json["angs5"],
        angs4: json["angs4"] == null ? null : json["angs4"],
        angs3: json["angs3"] == null ? null : json["angs3"],
        angs2: json["angs2"] == null ? null : json["angs2"],
        angs1: json["angs1"] == null ? null : json["angs1"],
      );

  Map<String, dynamic> toJson() => {
        "angs7": angs7 == null ? null : angs7,
        "angs6": angs6 == null ? null : angs6,
        "angs5": angs5 == null ? null : angs5,
        "angs4": angs4 == null ? null : angs4,
        "angs3": angs3 == null ? null : angs3,
        "angs2": angs2 == null ? null : angs2,
        "angs1": angs1 == null ? null : angs1,
      };
}

class Spp {
  Spp({
    this.angs6,
    this.angs5,
    this.angs4,
    this.angs3,
    this.angs1,
  });

  Angs angs6;
  Angs angs5;
  Angs angs4;
  Angs angs3;
  Angs1 angs1;

  factory Spp.fromJson(Map<String, dynamic> json) => Spp(
        angs6: json["angs6"] == null ? null : Angs.fromJson(json["angs6"]),
        angs5: json["angs5"] == null ? null : Angs.fromJson(json["angs5"]),
        angs4: json["angs4"] == null ? null : Angs.fromJson(json["angs4"]),
        angs3: json["angs3"] == null ? null : Angs.fromJson(json["angs3"]),
        angs1: json["angs1"] == null ? null : Angs1.fromJson(json["angs1"]),
      );

  Map<String, dynamic> toJson() => {
        "angs6": angs6 == null ? null : angs6.toJson(),
        "angs5": angs5 == null ? null : angs5.toJson(),
        "angs4": angs4 == null ? null : angs4.toJson(),
        "angs3": angs3 == null ? null : angs3.toJson(),
        "angs1": angs1 == null ? null : angs1.toJson(),
      };
}

class Detail {
  Detail({
    this.kampus,
    this.program,
    this.jurusan,
    this.lulusan,
    this.bulanan,
    this.kodeprg,
    this.kodejrs,
    this.kelompok,
  });

  Kampus kampus;
  Program program;
  String jurusan;
  Lulusan lulusan;
  String bulanan;
  Kodeprg kodeprg;
  String kodejrs;
  Kelompok kelompok;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        kampus:
            json["kampus"] == null ? null : kampusValues.map[json["kampus"]],
        program:
            json["program"] == null ? null : programValues.map[json["program"]],
        jurusan: json["jurusan"] == null ? null : json["jurusan"],
        lulusan:
            json["lulusan"] == null ? null : lulusanValues.map[json["lulusan"]],
        bulanan: json["bulanan"] == null ? null : json["bulanan"],
        kodeprg:
            json["kodeprg"] == null ? null : kodeprgValues.map[json["kodeprg"]],
        kodejrs: json["kodejrs"] == null ? null : json["kodejrs"],
        kelompok: json["kelompok"] == null
            ? null
            : kelompokValues.map[json["kelompok"]],
      );

  Map<String, dynamic> toJson() => {
        "kampus": kampus == null ? null : kampusValues.reverse[kampus],
        "program": program == null ? null : programValues.reverse[program],
        "jurusan": jurusan == null ? null : jurusan,
        "lulusan": lulusan == null ? null : lulusanValues.reverse[lulusan],
        "bulanan": bulanan == null ? null : bulanan,
        "kodeprg": kodeprg == null ? null : kodeprgValues.reverse[kodeprg],
        "kodejrs": kodejrs == null ? null : kodejrs,
        "kelompok": kelompok == null ? null : kelompokValues.reverse[kelompok],
      };
}

enum Kampus { UNIVERSITAS_MUHAMMADIYAH_SURABAYA }

final kampusValues = EnumValues({
  "Universitas Muhammadiyah Surabaya": Kampus.UNIVERSITAS_MUHAMMADIYAH_SURABAYA
});

enum Kelompok { D3, SMU }

final kelompokValues = EnumValues({"D3": Kelompok.D3, "SMU": Kelompok.SMU});

enum Kodeprg { P2_K }

final kodeprgValues = EnumValues({"P2K": Kodeprg.P2_K});

enum Lulusan { D3_KE_S1, SMU_KE_S1 }

final lulusanValues =
    EnumValues({"D3 ke S1": Lulusan.D3_KE_S1, "SMU ke S1": Lulusan.SMU_KE_S1});

enum Program { PROGRAM_PERKULIAHAN_KARYAWAN }

final programValues = EnumValues(
    {"Program Perkuliahan Karyawan": Program.PROGRAM_PERKULIAHAN_KARYAWAN});

class Itembayar {
  Itembayar({
    this.empty,
    this.itembayar,
  });

  int empty;
  int itembayar;

  factory Itembayar.fromJson(Map<String, dynamic> json) => Itembayar(
        empty: json[""] == null ? null : json[""],
        itembayar: json[" ()"] == null ? null : json[" ()"],
      );

  Map<String, dynamic> toJson() => {
        "": empty == null ? null : empty,
        " ()": itembayar == null ? null : itembayar,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
