List<String> USED_QUOTA = ["YA", "TIDAK"];
List<String> PAYMENT_METHOD = ["CASH", "TRANSFER"];
List<String> BILLING_STATUS = ["BELUM LUNAS", "DP", "LUNAS"];
List<String> PAYMENT_STATUS = ["MENUNGGU", "DISETUJUI", "DITOLAK"];
List<String> TITLE_CUSTOMER = ["TN", "NY"];
List<String> FILTER_BY = ["All", "Today", "This Month", "This Year"];
List<String> SATUAN_UNIT = [
  "Kg",
  "L",
  "Ons",
  "Tabung",
  "Jerigen",
  "KWh",
  "Gross",
  "Org",
  "Bulan"
];
List<String> FILTER_STATUS = ["PROGRESS", "COMPLETED", "CANCELED", "COMPLAINT"];
const String typeService = "REGULER";
const String jenisService = "CUCI KOMPLIT";
const String setrikaService = "SETRIKA";
const String libAssets = "assets";
const String libConfig = "$libAssets/config";
const String libImage = "$libAssets/images";
const String samplePhoto =
    "https://raw.githubusercontent.com/alamsyahh15/assetme/master/twt_clone/seller_sample.jpg";

DateTime dateNow = DateTime.now();
int lastday = DateTime(dateNow.year, dateNow.month + 1, 0).day;
DateTime lastMonth = DateTime(dateNow.year, dateNow.month, lastday);
DateTime firstMonth = DateTime(dateNow.year, dateNow.month, 1);
DateTime firstDate = DateTime(2000);
DateTime lastDate = DateTime(2060);
