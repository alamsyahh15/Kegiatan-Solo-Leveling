import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ma_laundry/data/local/account_data.dart';
import 'package:ma_laundry/data/model/laundry_form_model.dart/consumer_model.dart';
import 'package:ma_laundry/data/model/laundry_form_model.dart/create_consumer_model.dart';
import 'package:ma_laundry/data/model/laundry_form_model.dart/create_landry_model.dart';
import 'package:ma_laundry/data/model/laundry_form_model.dart/parfume_model.dart';
import 'package:ma_laundry/data/model/laundry_form_model.dart/service_kiloan_model.dart';
import 'package:ma_laundry/data/model/laundry_form_model.dart/service_satuan_model.dart';
import 'package:ma_laundry/data/network/network_export.dart';
import 'package:ma_laundry/ui/bloc/registrasi_laundry_bloc/registrasi_bloc.dart';

class RegistrasiFormRepo {
  /// API CREATE Consumer
  Future createConsumer(DataConsumer consumer, File foto) async {
    Map<String, dynamic> data = {};
    data["title"] = consumer?.title;
    data["nama_depan"] = consumer?.namaDepan;
    data["nama_belakang"] = consumer?.namaBelakang;
    data["username"] = consumer?.username;
    data["username"] = consumer?.username;
    data["pin"] = consumer?.kode;
    if (consumer?.telp != null) {
      data["telp"] = consumer?.telp;
    }
    if (consumer?.alamat != null) {
      data["alamat"] = consumer?.alamat;
    }
    if (foto != null) {
      data["foto"] = await MultipartFile.fromFile(foto.path);
    }
    log("Data Add Konsumen $data");

    try {
      Response res = await dio.post(CREATE_CONSUMER_URL,
          data: FormData.fromMap(data),
          options: Options(headers: apiHeader.headers));
      log("Add Konsumen ${res.data}");
      if (res.statusCode == 200) {
        return CreateConsumerModel.fromJson(res?.data)?.data;
      }
    } on DioError catch (e, st) {
      log("Exception $e");
      return DioHandler.parseDioErrorMessage(e, st);
    } catch (e) {
      log("Exception $e");
      return e;
    }
  }

  /// API GET Data Consumer
  Future searchDataConsumer() async {
    try {
      Response res = await dio.get(SEARCH_DATA_CONSUMER_URL,
          options: Options(headers: apiHeader.headers));
      if (res.statusCode == 200) {
        return ConsumerModel.fromJson(res?.data);
      }
    } on DioError catch (e, st) {
      log("Exception $e");
      return DioHandler.parseDioErrorMessage(e, st);
    } catch (e) {
      log("Exception $e");
      return e;
    }
  }

  /// API GET Service Kiloan
  Future getServiceKilos() async {
    try {
      Response res = await dio.get(SERVICE_KILOS_URL,
          queryParameters: {
            'id_cabang': accountData.account.idCabang,
          },
          options: Options(headers: apiHeader.headers));
      if (res.statusCode == 200) {
        return ServiceKiloanModel.fromJson(res?.data);
      }
    } on DioError catch (e, st) {
      log("Exception Kilos $e");
      return DioHandler.parseDioErrorMessage(e, st);
    } catch (e) {
      log("Exception Kilos $e");
      return e;
    }
  }

  /// API GET Service Satuan
  Future getServiceSatuan() async {
    try {
      Response res = await dio.get(SERVICE_SATUAN_URL,
          queryParameters: {
            'id_cabang': accountData?.account?.idCabang,
          },
          options: Options(headers: apiHeader.headers));
      if (res.statusCode == 200) {
        return ServiceSatuanModel.fromJson(res.data);
      }
    } on DioError catch (e, st) {
      log("Exception Satuan $e");
      return DioHandler.parseDioErrorMessage(e, st);
    } catch (e) {
      log("Exception Satuan $e");
      return e;
    }
  }

  /// API GET Data Parfum
  Future getParfume() async {
    try {
      Response res = await dio.get(PARFUME_URL,
          options: Options(headers: apiHeader.headers));
      if (res.statusCode == 200) {
        return ParfumeModel.fromJson(res.data);
      }
    } on DioError catch (e, st) {
      log("Exception $e");
      return DioHandler.parseDioErrorMessage(e, st);
    } catch (e) {
      log("Exception $e");
      return e;
    }
  }

  /// API GET Data Parfum
  Future createOrderLaundry(RegistrasiBloc bloc) async {
    try {
      Map<String, dynamic> data = {};
      data['id_konsumen'] = "${bloc?.valDataConsumer?.idKonsumen}";
      data['pakai_kuota'] = bloc?.valDataConsumer?.isKuota;
      data['kuota_cuci_used'] = bloc?.washingQuotaUsed;
      data['kuota_setrika_used'] = bloc?.setrikaQuotaUsed;
      data['parfum'] = bloc?.valParfume?.labelParfum;
      data['catatan'] = bloc?.noteVal == "null" ? null : bloc?.noteVal;
      data['luntur'] = "${bloc?.lunturVal}";
      data['tas_kantong'] = "${bloc?.tasKantongVal}";
      data['total_tagihan'] = bloc?.totalTagihan;
      data['status_tagihan'] = bloc?.billingStatusVal;
      data['metode_pembayaran'] = bloc?.paymentMethodVal;
      data['jumlah_bayar'] = bloc?.jumlahPembayaran;
      data['sisa_tagihan'] = bloc?.sisaTagihan;
      data['kembalian'] = bloc?.kembalian;
      data['diskon'] = bloc?.diskon;

      if ((bloc?.listInputKilos?.length ?? 0) > 0) {
        List<DataKiloan> listKiloan = bloc?.listInputKilos;
        for (int i = 0; i < listKiloan.length; i++) {
          DataKiloan dataKilos = listKiloan[i];
          data['id_service_kiloan[$i][id_service_kiloan]'] =
              "${dataKilos.idServiceKiloan}";
          data['id_service_kiloan[$i][nama_service]'] =
              "${dataKilos.namaService}";
          data["id_service_kiloan[$i][tipe_service]"] =
              "${dataKilos.tipeService}";
          data["id_service_kiloan[$i][jenis_service]"] =
              "${dataKilos.jenisService}";
          data["id_service_kiloan[$i][jumlah]"] = "${dataKilos.berat}";
          data["id_service_kiloan[$i][satuan_jumlah]"] =
              "${dataKilos.satuanUnit}";
          data["id_service_kiloan[$i][durasi]"] = "${dataKilos.durasi}";
          data["id_service_kiloan[$i][satuan_durasi]"] =
              "${dataKilos.satuanWaktu}";
          data["id_service_kiloan[$i][harga]"] = "${dataKilos.harga}";
        }
      }
      if ((bloc?.listInputUnit?.length ?? 0) > 0) {
        for (int i = 0; i < bloc?.listInputUnit?.length; i++) {
          DataSatuan dataSatuan = bloc?.listInputUnit[i];
          data["id_service_satuan[$i][id_service_satuan]"] =
              "${dataSatuan.idServiceSatuan}";
          data["id_service_satuan[$i][nama_service]"] =
              "${dataSatuan.namaService}";
          data["id_service_satuan[$i][jenis_service]"] = "undefined";
          data["id_service_satuan[$i][jumlah]"] = "${dataSatuan.jumlah}";
          data["id_service_satuan[$i][durasi]"] = "${dataSatuan.durasi}";
          data["id_service_satuan[$i][satuan_durasi]"] =
              "${dataSatuan.satuanWaktu}";
          data["id_service_satuan[$i][harga]"] = "${dataSatuan.harga}";
        }
      }

      if (bloc?.photoAdditional != null) {
        data["laundry_photo"] =
            await MultipartFile.fromFile(bloc?.photoAdditional?.path);
      }
      log("Query ${jsonEncode(data)}");

      Response res = await dio.post(
        CREATE_LAUNDRY_URL,
        data: FormData.fromMap(data),
        options: Options(headers: apiHeader.headers),
      );
      if (res.statusCode == 200) {
        return CreateLaundryModel.fromJson(res.data).data;
      }
    } on DioError catch (e, st) {
      log("Exception $e");
      return DioHandler.parseDioErrorMessage(e, st);
    } catch (e) {
      log("Exception $e");
      return e;
    }
  }
}

final registrasiFormRepo = RegistrasiFormRepo();
