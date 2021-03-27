import 'package:global_configuration/global_configuration.dart';

final String rootUrl = GlobalConfiguration().get("rootUrl").toString();
final String baseUrl = "$rootUrl" + "/api";
final String NOTIFICATION_URL = "$baseUrl/notification/getNotif";
final String APP_CONFIG_URL = '$baseUrl/app_config';
final String LOGIN_URL = "$baseUrl/login";
final String DATA_USER_URL = "$baseUrl/user/getData";
final String SET_FIREBASE_URL = "$baseUrl/user/set_firebase_token/";
final String SEARCH_DATA_CONSUMER_URL = "$baseUrl/konsumen/getData";
final String SERVICE_KILOS_URL = "$baseUrl/service_kiloan/getData";
final String SERVICE_SATUAN_URL = "$baseUrl/service_satuan/getData";
final String PARFUME_URL = "$baseUrl/parfum/getData?filter=&is_active=ALL";
final String CREATE_LAUNDRY_URL = "$baseUrl/laundry/create";
final String CREATE_CONSUMER_URL = "$baseUrl/konsumen/create";
final String DATA_LAUNDRY_URL = "$baseUrl/laundry/getData";
final String SET_COMPLETE_LAUNDRY_URL = "$baseUrl/laundry/update_status/";
final String SET_CANCEL_LAUNDRY_URL = "$baseUrl/laundry/cancel/";
final String DATA_PENGELUARAN_URL = "$baseUrl/pengeluaran/getData";
final String CREATE_PENGELUARAN_URL = "$baseUrl/pengeluaran/create";
final String DATA_ITEM_URL = "$baseUrl/item/getData";
final String AMBIL_LAUNDRY_URL = "$baseUrl/laundry/ambil_order/";
final String TOTAL_KAS_URL = "$baseUrl/kas_laundry/getTotals";
final String DATA_KAS_URL = "$baseUrl/transaksi_paket/getData";
final String DATA_TRANSACTION_URL = "$baseUrl/transaksi_paket/getData";
final String PAKET_KUOTA_URL = "$baseUrl/paket_kuota/getData";
final String CREATE_PAKET_KUOTA_URL = "$baseUrl/transaksi_paket/create";
final String REQUEST_JEMPUT_URL = "$baseUrl/request_jemput/getData";
final String UPDATE_REQ_JEMPUT_URL = "$baseUrl/request_jemput/update/";
final String REQUEST_ANTAR_URL = "$baseUrl/request_antar/getData";
final String UPDATE_REQ_ANTAR_URL = "$baseUrl/request_antar/update/";
final String APPROVAL_PEMBAYARAN_URL = "$baseUrl/laundry/pembayaran/approval/";
final String DETAIL_PEMBAYARAN_URL = "$baseUrl/laundry/detail_pembayaran/";
final String KONSUMEN_URL = "$baseUrl/konsumen/";
final String INBOX_URL = "$baseUrl/chat/";
final String CHECK_USER = "$baseUrl/cek_user";
final String RESET_PIN = "$baseUrl/user_update/";
String buktiPhotoUrl(kodeTransaksi, buktiFile) =>
    "https://si.malaundry.co.id/bukti_pembayaran/$kodeTransaksi/$buktiFile";
String photoConsumerUrl(kode, nameFile) =>
    "https://si.malaundry.co.id/konsumen/$kode/$nameFile";
