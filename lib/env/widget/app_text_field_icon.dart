// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:report_sarang/env/variable/app_constant.dart';
import 'package:report_sarang/env/widget/app_text.dart';

class AppTextFieldIcon extends StatefulWidget {
  const AppTextFieldIcon({
    super.key,
    required this.label,
    required this.hint,
    required this.textController,
    required this.validator,
    this.isPassword = false,
    this.withIcon = true,
    this.iconPrefix,
    this.onSubmitted,
  });

  final String label, hint;
  final TextEditingController textController;
  final String? Function(String?) validator;
  final bool isPassword, withIcon;
  final String? iconPrefix;
  final void Function(String)? onSubmitted;

  @override
  State<AppTextFieldIcon> createState() => _AppTextFieldIconState();
}

class _AppTextFieldIconState extends State<AppTextFieldIcon> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(text: widget.label, size: 12, weight: FontWeight.w600),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.textController,
          validator: widget.validator,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          onFieldSubmitted: widget.onSubmitted,
          decoration: InputDecoration(
            hintText: widget.hint,
            errorMaxLines: 99,
            prefixIcon: Image.asset(
              widget.iconPrefix!,
              width: 20,
              height: 20,
              color: My.grey,
            ),
            contentPadding: const EdgeInsets.all(10),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(5.0),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(5.0),
            ),
            hintStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
            ),
            errorStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            isDense: true,
            filled: true,
            fillColor: My.grey2.withOpacity(0.60),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
