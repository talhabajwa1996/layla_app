import 'package:flutter/material.dart';

import '../../AppTheme/ColorConstants.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final bool isEnable, isObscure;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(String)? onChange;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmit;
  final TextInputAction? inputAction;
  final bool readOnly;
  final Widget? suffixWidget, prefixWidget;
  final Function()? onTap;
  final VoidCallback? onPressedLeadingIcon;
  final String? labelText;
  final double? padding;
  final int? maxLines;
  final String? initialValue;
  final Color? cursorColor;
  final Color? fillColor;
  final Color? textColor;
  final TextStyle? hintStyle;
  final void Function(String?)? onSaved;
  final EdgeInsetsGeometry? contentPadding;
  final BorderRadius borderRadius;

  CustomTextFormField(
      {this.validator,
      this.hintStyle,
      this.textColor,
      this.fillColor,
      this.contentPadding,
      this.initialValue,
      this.cursorColor,
      this.inputAction,
      this.borderRadius = const BorderRadius.all(Radius.circular(4.0)),
      this.isEnable = true,
      this.isObscure = false,
      this.onFieldSubmit,
      this.prefixWidget,
      this.hintText,
      this.inputType,
      this.controller,
      this.focusNode,
      this.onChange,
      this.onTap,
      this.suffixWidget,
      this.readOnly = false,
      this.onPressedLeadingIcon,
      this.labelText,
      this.onSaved,
      this.maxLines = 1,
      this.padding = 0.0,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextFormField(
          style: TextStyle(fontSize: 16, color: textColor ?? ColorConstants.textColorGrey),
          cursorColor: cursorColor ?? ColorConstants.textColorGrey,
          onTap: onTap,
          enabled: isEnable,
          obscureText: isObscure,
          focusNode: focusNode,
          onFieldSubmitted: onFieldSubmit,
          initialValue: initialValue,
          controller: controller,
          textInputAction: inputAction,
          keyboardType: inputType,
          maxLines: maxLines,
          readOnly: readOnly,
          decoration: InputDecoration(
              prefixIcon: prefixWidget,
              suffixIcon: suffixWidget,
              hintText: hintText,
              labelText: labelText,
              contentPadding: contentPadding,
              fillColor: fillColor ?? ColorConstants.white,
              labelStyle: const TextStyle(
                  color: ColorConstants.textColorGrey, fontSize: 25.0),
              hintStyle: hintStyle ??
                  const TextStyle(
                      color: ColorConstants.textColorGrey,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black54),
                  borderRadius: borderRadius),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black54),
                  borderRadius: borderRadius),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black54),
                  borderRadius: borderRadius),
              errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black54),
                  borderRadius: borderRadius),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black54),
                  borderRadius: borderRadius),
              errorStyle:
                  const TextStyle(color: ColorConstants.red, height: 1.1),
              errorMaxLines: 3,
              // contentPadding: EdgeInsets.only(left: 10.0, top: padding),
              // fillColor: Colors.white,
              filled: true),
          validator: validator,
          onChanged: onChange,
          onSaved: onSaved,
        ),
      ],
    );
  }
}
