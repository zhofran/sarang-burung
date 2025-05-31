// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DateRangePickerWidget {
  /// Fungsi untuk menampilkan Date Picker dalam Popup/Dialog dan mengembalikan nilai yang dipilih
  static Future<String?> showDatePickerDialog(BuildContext context, {String? initialRange}) async {
    DateTime startDate = DateTime.now();
    DateTime endDate = DateTime.now();

    if (initialRange != null && initialRange.contains(' - ')) {
      List<String> dates = initialRange.split(' - ');
      startDate = DateFormat('dd/MM/yyyy').parse(dates[0]);
      endDate = DateFormat('dd/MM/yyyy').parse(dates[1]);
    }

    PickerDateRange selectedRange = PickerDateRange(startDate, endDate);

    return await showDialog<String>(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Pilih Rentang Tanggal",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                SfDateRangePicker(
                  backgroundColor: Colors.white,
                  selectionColor: Colors.green,
                  rangeSelectionColor: Colors.green.withOpacity(0.2),
                  todayHighlightColor: Colors.green,
                  startRangeSelectionColor: Colors.green,
                  endRangeSelectionColor: Colors.green,
                  onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                    if (args.value is PickerDateRange) {
                      selectedRange = args.value;
                    }
                  },
                  selectionMode: DateRangePickerSelectionMode.range,
                  initialSelectedRange: selectedRange,
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, null), // Tutup tanpa memilih
                      child: const Text(
                        "Batal",
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        String formattedRange =
                            '${DateFormat('dd/MM/yyyy').format(selectedRange.startDate ?? DateTime.now())} - '
                            '${DateFormat('dd/MM/yyyy').format(selectedRange.endDate ?? selectedRange.startDate ?? DateTime.now())}';

                        Navigator.pop(context, formattedRange); // Kembalikan nilai ke parent
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Pilih",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
