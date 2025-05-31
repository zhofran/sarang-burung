import 'package:flutter/material.dart';
import 'package:report_sarang/env/class/app_shortcut.dart';
import 'package:report_sarang/env/variable/app_constant.dart';

class DashSeparator extends StatelessWidget {
  const DashSeparator({
    super.key,
    this.height = 1,
    this.color,
  });

  final double height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    var my = AppShortcut.of(context);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = my.query.size.width;
        const dashWidth = 5.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Flex(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.horizontal,
            children: List.generate(dashCount, (_) {
              return SizedBox(
                width: dashWidth,
                height: dashHeight,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: color ?? My.grey),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
