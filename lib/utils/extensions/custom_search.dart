import 'package:flutter/material.dart';
import 'package:the_entrapreneu/utils/constants/app_colors.dart';

class CustomSearchField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Function(String)? onChanged;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final Color hintColor;
  final double height;
  final double borderRadius;
  final bool showClearButton;

  const CustomSearchField({
    super.key,
    this.controller,
    this.hintText = "Search...",
    this.onChanged,
    this.backgroundColor = Colors.white,
    this.borderColor = const Color(0xFFEDEDED),
    this.textColor = AppColors.black,
    this.hintColor = AppColors.textSecond,
    this.height = 44,
    this.borderRadius = 10,
    this.showClearButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: StatefulBuilder(
        builder: (context, setState) {
          return TextField(
            controller: controller,
            onChanged: (value) {
              if (onChanged != null) onChanged!(value);
              setState(() {}); // refresh to show/hide clear button
            },
            style: TextStyle(color: textColor, fontSize: 14),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: hintColor, fontSize: 14),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(Icons.search, color: hintColor, size: 20),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 16,
              ),
              filled: true,
              fillColor: backgroundColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: borderColor, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: borderColor, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: borderColor, width: 1),
              ),
            ),
          );
        },
      ),
    );
  }
}
