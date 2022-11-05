import 'package:flutter/material.dart';

import '../../utils/App-TextStyle.dart';
import '../../utils/app_colors.dart';


class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.height = 60,
    required this.width,
    this.bgColor,
    this.borderColor,
    this.label,
    this.hint,
    this.leading,
    this.trailing,
    this.hintStyle,
    this.textStyle,
    this.obsecure,
    required this.controller, this.onChange, this.onSaved,
  });

  final double height;
  final double width;
  final Color? bgColor;
  final Color? borderColor;
  final String? label;
  final String? hint;
  final Widget? leading;
  final Widget? trailing;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final bool? obsecure;
  final Function(String?)? onChange;
  final Function(String?)? onSaved;
  final TextEditingController controller;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          width: 1,
          color: widget.borderColor?.withOpacity(0.5) ?? Colors.transparent,
        ),
      ),
      child: Container(
        height: widget.height,
        width: widget.width,

        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        decoration: BoxDecoration(
          color: widget.bgColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          children: [
            Container(margin: const EdgeInsets.only(right: 14), child: widget.leading),
            Expanded(
              child: TextField(
                controller: widget.controller,
                obscureText: widget.obsecure ?? false,
                style: widget.textStyle,
                onChanged: widget.onChange,
                maxLength: 28,
                autocorrect: false,
                enableSuggestions: false,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  counterText: '',
                  hintText: widget.hint ?? '',
                  hintStyle: widget.hintStyle,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.only(bottom: 10),
                ),
              ),
            ),
            Container(margin: const EdgeInsets.only(right: 0), child: widget.trailing),
          ],
        ),
      ),
    );
  }
}
