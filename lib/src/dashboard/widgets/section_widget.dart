import 'package:flutter/material.dart';

class SectionWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final String total;
  final String percentage;
  final Color percentageColor;
  final List<String> tableHeaders;
  final List<List<String>> tableRows;
  final List<TextStyle> columnStyles;

  const SectionWidget({super.key, 
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.total,
    required this.percentage,
    required this.percentageColor,
    required this.tableHeaders,
    required this.tableRows,
    required this.columnStyles,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor),
              SizedBox(width: 8),
              Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(total, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Icon(Icons.arrow_upward, color: percentageColor),
                  SizedBox(width: 4),
                  Text(percentage, style: TextStyle(color: percentageColor, fontSize: 16)),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          Table(
            border: TableBorder.all(color: Colors.grey),
            columnWidths: {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: Colors.grey[200]),
                children: tableHeaders
                    .map((header) => Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(header, style: TextStyle(fontWeight: FontWeight.bold)),
                        ))
                    .toList(),
              ),
              ...tableRows.map((row) => TableRow(
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    children: row.asMap().entries.map((entry) {
                      int index = entry.key;
                      String cell = entry.value;
                      return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(cell, style: columnStyles[index]),
                      );
                    }).toList(),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}