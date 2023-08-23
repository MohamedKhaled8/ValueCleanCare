import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vc/theme/constant/const_colors.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  final String text;
  final TextInputType type;
  String? Function(String?)? validate;
  TextEditingController? controller;
  final int? maxLen;
  final bool? visaData;
  final bool? enable;
  final bool suffixIcon;
  Icon? icon;
  final String fieldName;
  // ignore: non_constant_identifier_name
  String _mmYY = '';
  final int? textFiledIndex;
  VoidCallback? suffixIconOnTap;
  CustomTextFormField({
    Key? key,
    required this.text,
    this.icon,
    required this.type,
    this.controller,
    this.validate,
    this.maxLen,
    this.visaData,
    this.enable = true,
    this.suffixIcon = false,
    this.textFiledIndex,
    this.fieldName = '',
    this.suffixIconOnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enable,
      // textDirection: TextDirection.rtl,
      maxLength: maxLen,
      validator: validate,
      obscureText: suffixIcon,
      autofocus: false,
      controller: controller,
      textInputAction: TextInputAction.next,
      onSaved: (newValue) {},
      keyboardType: type,
      enableSuggestions: true,
      onChanged: (value) {
        if (visaData != null && visaData!) {
          if (value.length == 2 && value.length > _mmYY.length) {
            controller!.text = '/$value';
            _mmYY = controller!.text;
          } else {
            _mmYY = controller!.text;
          }
        }
      },
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.green),
          borderRadius: BorderRadius.circular(10).w,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10).w,
          borderSide: const BorderSide(width: 1, color: Colors.green),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10).w,
          borderSide: const BorderSide(width: 1, color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10).w,
          borderSide: const BorderSide(width: 1, color: Colors.red),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10).w,
          borderSide: BorderSide(width: 1, color: ColorApp.primary),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20).r,
        hintText: text,
        hintStyle: TextStyle(
            fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.grey),
        fillColor: Colors.white,
        filled: true,
        // prefixIcon: icon,
        suffixIcon: fieldName == 'password'
            ? InkWell(
                onTap: suffixIconOnTap,
                child: suffixIcon
                    ? Icon(
                        Icons.remove_red_eye_outlined,
                        color: Colors.white,
                        size: 30.sp,
                      )
                    : Icon(
                        Icons.visibility_off,
                        color: Colors.white,
                        size: 30.sp,
                      ),
              )
            : const SizedBox(),
      ),
    );
  }
}
