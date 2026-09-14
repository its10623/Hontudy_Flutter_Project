import 'package:flutter/material.dart';

import '../../core/theme/context_theme_extension.dart';

class CheckBoxWidget extends StatefulWidget {
  final bool isChecked;
  final ValueChanged<bool> onCheckedChanged;
  final OutlinedBorder? shape;
  final Widget text;

  const CheckBoxWidget({super.key, required this.isChecked, required this.onCheckedChanged, this.shape, required this.text});

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => widget.onCheckedChanged(!widget.isChecked),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
              value: widget.isChecked,
              onChanged: (value) =>
                  widget.onCheckedChanged(value ?? false),
              shape: widget.shape ?? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              side: BorderSide(color: context.colors.outline, width: 1.5),
            ),
            widget.text
          ],
        ),
      ),
    );
  }
}
