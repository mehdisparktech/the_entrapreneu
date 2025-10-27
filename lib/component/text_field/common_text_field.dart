import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/constants/app_colors.dart';
import '../text/common_text.dart';

class CommonTextField extends StatefulWidget {
  const CommonTextField({
    super.key,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.isPassword = false,
    this.controller,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.mexLength,
    this.validator,
    this.prefixText,
    this.paddingHorizontal = 16,
    this.paddingVertical = 14,
    this.borderRadius = 10,
    this.inputFormatters,
    this.fillColor = AppColors.white,
    this.hintTextColor = AppColors.textFiledColor,
    this.labelTextColor = AppColors.textFiledColor,
    this.textColor = AppColors.textColors,
    this.borderColor = AppColors.borderColor,
    this.onSubmitted,
    this.onTap,
    this.suffixIcon,
    this.maxLines,
  });

  final String? hintText;
  final String? labelText;
  final String? prefixText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? fillColor;
  final Color? labelTextColor;
  final Color? hintTextColor;
  final Color? textColor;
  final Color borderColor;
  final double paddingHorizontal;
  final double paddingVertical;
  final double borderRadius;
  final int? mexLength;
  final bool isPassword;
  final Function(String)? onSubmitted;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final TextInputAction textInputAction;
  final FormFieldValidator? validator;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  bool obscureText = true;

  @override
  void initState() {
    super.initState();
    if (!widget.isPassword) obscureText = false;
  }

  void toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: widget.fillColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        shadows: [
          BoxShadow(
            color: const Color(0x19000000),
            blurRadius: 4,
            offset: const Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUnfocus,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        obscureText: widget.isPassword ? obscureText : false,
        textInputAction: widget.textInputAction,
        maxLength: widget.mexLength,
        maxLines: widget.maxLines ?? 1,
        cursorColor: AppColors.white,
        inputFormatters: widget.inputFormatters,
        style: TextStyle(fontSize: 14, color: widget.textColor),
        onFieldSubmitted: widget.onSubmitted,
        onTap: widget.onTap,
        validator: widget.validator,
        decoration: InputDecoration(
          errorMaxLines: 2,
          filled: true,
          prefixIcon: widget.prefixIcon,
          fillColor: Colors.transparent,
          counterText: "",
          contentPadding: EdgeInsets.symmetric(
            horizontal: widget.paddingHorizontal.w,
            vertical: widget.paddingVertical.h,
          ),
          border: _buildBorder(),
          enabledBorder: _buildBorder(),
          focusedBorder: _buildBorder(),
          disabledBorder: _buildBorder(),
          errorBorder: _buildBorder(),
          hintText: widget.hintText,
          labelText: widget.labelText,
          hintStyle: GoogleFonts.poppins(
            fontSize: 14,
            color: widget.hintTextColor,
          ),
          labelStyle: GoogleFonts.poppins(
            fontSize: 14,
            color: widget.labelTextColor,
          ),
          prefix: CommonText(
            text: widget.prefixText ?? "",
            fontWeight: FontWeight.w400,
          ),
          suffixIcon: widget.isPassword
              ? GestureDetector(
            onTap: toggle,
            child: Padding(
              padding: EdgeInsetsDirectional.only(end: 10.w),
              child: Icon(
                obscureText
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: 20.sp,
                color: widget.textColor,
              ),
            ),
          )
              : widget.suffixIcon,
        ),
      ),
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius.r),
      borderSide: BorderSide(color: widget.borderColor),
    );
  }
}
