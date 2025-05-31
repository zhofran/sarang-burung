// ignore_for_file: unnecessary_import, deprecated_member_use

import 'dart:developer';

import 'package:report_sarang/env/widget/app_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

double calculateIndicatorPosition(double value, double minThreshold, double threshold) {
  if (value < minThreshold) {
    return 100; // Far left (Bad side)
  } else if (value > threshold) {
    return 0; // Far right (Bad side)
  } else if (value <= threshold) {
    return (value / threshold) * 50; // Left of center (Good side)
  } else {
    return 50 + ((value - threshold) / threshold) * 50; // Right of center (Bad side)
  }
}

double calculateHumidityIndicatorPosition(double value, double humidityThreshold) {
  if (value <= humidityThreshold) {
    return (value / humidityThreshold) * 50; // Left of center (Good side)
  } else {
    return 50 + ((value - humidityThreshold) / humidityThreshold) * 50; // Right of center (Bad side)
  }
}

double calculateAmoniaIndicatorPosition(double value, double amoniaThreshold) {
  if (value <= amoniaThreshold) {
    return (value / amoniaThreshold) * 50; // Left of center (Good side)
  } else {
    return 50 + ((value - amoniaThreshold) / amoniaThreshold) * 50; // Right of center (Bad side)
  }
}


Widget sensorCard(String sensorId, double value, bool isActive, double minThreshold, double threshold, String format) {

  log('Sensor $sensorId value: $value');
  log('Sensor $sensorId isActive: $isActive');
  log('Sensor $sensorId minThreshold: $minThreshold');
  log('Sensor $sensorId threshold: $threshold');
  log('Sensor $sensorId format: $format');

  double indicatorPosition = 0.0;

  if(format == '°C') {
    indicatorPosition = calculateIndicatorPosition(value, minThreshold, threshold);
  }

  if(format == '%') {
    indicatorPosition = calculateHumidityIndicatorPosition(value, threshold);
  }

  if(format == 'PPM') {
    indicatorPosition = calculateAmoniaIndicatorPosition(value, threshold);
  }

  log('Sensor $sensorId indicatorPosition: $indicatorPosition');

  return AppCard(
    padding: const EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min, // Menyesuaikan ukuran berdasarkan kontennya
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sensor',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            Text(
              sensorId,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 5), // Spasi tambahan agar tidak terlalu padat
        Text(
          '$value $format',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        LayoutBuilder(
          builder: (context, constraints) {
            double maxWidth = constraints.maxWidth; // Ambil ukuran parent container
            double indicatorLeft = (maxWidth * (indicatorPosition / 100)).clamp(0, maxWidth - 5);

            return Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  height: 5,
                  width: maxWidth, // Sesuaikan lebar dengan parent
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: const LinearGradient(
                      colors: [Colors.red, Colors.orange, Colors.yellow, Colors.green],
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                    ),
                  ),
                ),
                Positioned(
                  left: indicatorLeft, // Gunakan nilai yang sudah dikalkulasi agar tidak overflow
                  child: Container(
                    width: 5,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('Good', style: TextStyle(fontSize: 12)),
            Text('Bad', style: TextStyle(fontSize: 12)),
          ],
        ),
        Text(
          isActive ? 'Hidup' : 'Mati',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: isActive ? Colors.green : Colors.red,
          ),
        ),
      ],
    ),
  );
}