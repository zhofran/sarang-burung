part of '../class/app_env.dart';

class AppParse {
  static String formatDate(DateTime time,
      {required String Function(AppDateModel value) format}) {
    return format(AppDateModel.fromDate(time));
  }

  static String formattedDate({
    required String date,
    String? format = 'd MMMM yyyy',
}) {
    return DateFormat(format, 'id_ID').format(DateTime.parse(date));
  }

  // format rupiah
  static String formatRupiah(int value) {
    final formatter = NumberFormat.simpleCurrency(locale: 'id_ID');
    return formatter.format(value);
  }

  static String formatNumber(int value) {
    final formatter = NumberFormat.decimalPattern('id_ID');
    return formatter.format(value);
  }

  static bool isSensorAlive(Sensor sensor) {
    final now = DateTime.now().millisecondsSinceEpoch;

    final lastUpdatedAtMs = sensor.lastUpdatedAt! * (sensor.lastUpdatedAt! < 1000000000 ? 1000 : 1);

    final thresholdLiveSensor = Duration(seconds: 60 * 1000).inMilliseconds;

    return now - lastUpdatedAtMs <= thresholdLiveSensor;
  }

  static String formatVaNumber(String input) {
    List<String> chunks = [];
    int length = input.length;
    int index = 0;
    while (index < length) {
      int end = index + 4;
      if (end > length) {
        end = length;
      }
      chunks.add(input.substring(index, end));
      index = end;
    }
    return chunks.join(' ');
  }
}
