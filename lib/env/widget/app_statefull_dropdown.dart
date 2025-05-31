// ignore_for_file: library_private_types_in_public_api, use_super_parameters, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:report_sarang/env/class/app_shortcut.dart';
import 'package:report_sarang/env/variable/app_constant.dart';
import 'package:report_sarang/env/variable/variable_shortcut.dart';
import 'package:report_sarang/env/widget/app_text.dart';

class AppDropdownValueController extends ValueNotifier<int?> {
  AppDropdownValueController([this._value]) : super(_value);
  int? _value;

  @override
  int? get value => _value;

  @override
  set value(int? newValue) {
    _value = (newValue == null || newValue < 0) ? null : newValue;
    notifyListeners();
  }

  bool isValid(int length) => value != null && value! >= 0 && value! < length;
}

class AppDropdown extends StatelessWidget {
  const AppDropdown(
      {Key? key,
      this.topText,
      this.border,
      this.style,
      this.hint,
      this.topTextStyle,
      this.initialValue,
      this.editable = true,
      this.margin,
      this.color,
      this.onChanged,
      required this.values})
      : super(key: key);
  final String? topText;
  final TextStyle? topTextStyle, style;
  final EdgeInsetsGeometry? margin;
  final List<String> values;
  final String? hint;
  final int? initialValue;
  final void Function(int? value)? onChanged;
  final Color? color;
  final BoxBorder? border;
  final bool editable;

  @override
  Widget build(BuildContext context) {
    var my = AppShortcut.of(context);

    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (topText != null)
            AppText(
              text: topText!,
              size: 12,
              weight: FontWeight.w600,
            ),
          if (topText != null) const SizedBox(height: 8),
          Container(
            alignment: Alignment.centerLeft,
            padding: insetAll(10),
            decoration: BoxDecoration(
              color: color ??
                  (!editable ? my.color.primary.withOpacity(0.1) : My.grey3),
              borderRadius: radiusAll(
                circular(5.0),
              ),
              border: border ??
                  Border.all(
                    width: 1,
                    color: My.grey4,
                  ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: DropdownButton<int>(
                    underline: const SizedBox(),
                    isDense: true,
                    isExpanded: true,
                    value: initialValue,
                    style: style ??
                        my.text.bodyMedium?.copyWith(
                          fontSize: 12.0,
                          color: my.color.shadow,
                        ),
                    hint: hint == null
                        ? null
                        : AppText(
                            text: hint!,
                            size: 12,
                            weight: FontWeight.w600,
                            textColor: editable
                                ? my.color.onBackground
                                : my.color.onBackground.withOpacity(0.5),
                          ),
                    onChanged: !editable
                        ? null
                        : (value) {
                            if (onChanged != null) onChanged!(value);
                          },
                    items: List.generate(
                      values.length,
                      (x) => DropdownMenuItem(
                        value: x,
                        onTap: editable ? null : () {},
                        child: Text(
                          values[x],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: style ??
                              my.text.labelSmall?.copyWith(
                                fontSize: 12.0,
                                color: editable
                                    ? my.color.onBackground
                                    : my.color.onBackground.withOpacity(0.5),
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AppStatefulDropdown extends StatefulWidget {
  const AppStatefulDropdown({
    Key? key,
    required this.controller,
    required this.values,
    this.editable = true,
    this.hint,
    this.margin,
    this.topTextStyle,
    this.autoDispose = true,
    this.topText,
    this.validator,
    this.onChanged,
  }) : super(key: key);
  final AppDropdownValueController controller;
  final List<String> values;
  final EdgeInsetsGeometry? margin;
  final String? topText, hint;
  final TextStyle? topTextStyle;
  final bool autoDispose, editable;
  final String? validator;
  final Function()? onChanged;

  @override
  _AppStatefulDropdownState createState() => _AppStatefulDropdownState();
}

class _AppStatefulDropdownState extends State<AppStatefulDropdown> {
  late int? value = (widget.controller.value ?? -1) > widget.values.length
      ? null
      : widget.controller.value != null && widget.controller.value! < 0
          ? null
          : widget.controller.value;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (mounted) {
        setState(() => value = widget.controller.value);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.autoDispose) widget.controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var my = AppShortcut.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppDropdown(
          editable: widget.editable,
          color: !widget.editable ? my.color.primary.withOpacity(0.1) : null,
          style: my.text.labelSmall?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppConstant.black,
          ),
          margin: widget.margin,
          topText: widget.topText,
          topTextStyle: widget.topTextStyle ??
              my.text.labelSmall?.copyWith(
                  color: my.color.onBackground.withOpacity(0.5),
                  fontSize: 11.0),
          hint: widget.hint ?? "Belum Dipilih",
          values: widget.values,
          initialValue: value,
          onChanged: (value) {
            if ((value ?? 0) >= widget.values.length) {
              widget.controller.value = null;
            } else {
              widget.controller.value = value;
            }
            if (widget.onChanged != null) widget.onChanged!();
          },
        ),
        if (widget.validator != null)
          Column(
            children: [
              const SizedBox(height: 6),
              AppText(
                text: '   ${widget.validator!}',
                size: 13,
                weight: FontWeight.w500,
                textColor: Colors.red,
              ),
            ],
          )
      ],
    );
  }
}
