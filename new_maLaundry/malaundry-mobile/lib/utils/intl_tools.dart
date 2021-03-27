import 'package:intl/intl.dart';

String formatMoney(val) {
  String money = "";
  if (val != null) {
    if (val is String) {
      money = NumberFormat.currency(
        decimalDigits: 0,
        symbol: "Rp. ",
        locale: "id",
      ).format(double.parse(val).round());
    } else {
      double newVal = double.parse("$val");
      money = money = NumberFormat.currency(
        decimalDigits: 0,
        locale: "id",
        symbol: "Rp. ",
      ).format(newVal.round());
    }
  }
  return money;
}

enum FormatTypeDate { DDMMYYYY, YYYYMMDD }
String getTimes(DateTime date) {
  String times = "";
  if (date != null) {
    times = DateFormat.Hm().format(date);
  }
  return times;
}

String formatDate(DateTime dateNow,
    {bool withTimes = false,
    FormatTypeDate formatType = FormatTypeDate.YYYYMMDD}) {
  String date = "yyyy/dd/hh";
  if (dateNow != null) {
    switch (FormatTypeDate.DDMMYYYY) {
      case FormatTypeDate.DDMMYYYY:
        // TODO: Handle this case.
        date = DateFormat("dd-MM-yyyy").format(dateNow);
        if (withTimes) {
          date = DateFormat("dd MMMM yyyy hh:mm:ss").format(dateNow);
        }

        break;
      case FormatTypeDate.YYYYMMDD:
        // TODO: Handle this case.
        date = DateFormat("yyyy-MM-dd").format(dateNow);
        if (withTimes) {
          date = DateFormat("dd MMMM yyyy hh:mm:ss").format(dateNow);
        }
        break;
    }
  }

  return date;
}
