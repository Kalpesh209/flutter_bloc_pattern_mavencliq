import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mavencliq/Ui_Config/app_colors.dart';
import 'package:mavencliq/Ui_Config/app_images.dart';
import 'package:mavencliq/Ui_Config/text_style.dart';

class TextFormFieldWidget extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final bool isPasswordField;
  final bool? isPhoneField;
  final TextInputAction inputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final FocusNode? focusNode;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final Function()? onTextFieldTap;
  final Widget? suffixIcon;
  final bool isRead;
  final int maxline;
  const TextFormFieldWidget({
    required this.controller,
    required this.isPasswordField,
    required this.inputAction,
    required this.onFieldSubmitted,
    required this.validator,
    this.onChanged,
    this.textInputType = TextInputType.text,
    this.hint = '',
    this.focusNode,
    this.isPhoneField,
    this.enabled = true,
    this.isRead = false,
    this.suffixIcon,
    this.onTextFieldTap,
    this.maxline = 1,
    Key? key,
  }) : super(key: key);

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    if (widget.isPasswordField) {
      return _getPasswordField();
    } else {
      return _getNormalField();
    }
  }

  Widget _getPasswordField() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.kDropDownBackColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: AppColors.kDropDownBackColor,
            width: 1,
          )
      ),
      child: TextFormField(
        controller: widget.controller,
        obscuringCharacter: "*",
        validator: (value) {
          return widget.validator!(value);
        },
        focusNode: widget.focusNode,
        textInputAction: widget.inputAction,
        obscureText: !isPasswordVisible,
        enableSuggestions: false,
        enabled: widget.enabled,
        autocorrect: false,
        onFieldSubmitted: widget.onFieldSubmitted,
        onChanged: widget.onChanged,
        autovalidateMode: AutovalidateMode.disabled,
        textAlignVertical: TextAlignVertical.bottom,
        cursorColor: AppColors.kFontColor.withOpacity(0.3),
        keyboardType: widget.textInputType,
        style: _getTextStyle(),
        decoration: _getPasswordInputDecoration(),
        maxLines: widget.maxline,
      ),
    );
  }

  Widget _getNormalField() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.kDropDownBackColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: AppColors.kDropDownBackColor,
          width: 1,
        )
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              showCursor: true,
              readOnly: widget.isRead,
              controller: widget.controller,
              style: _getTextStyle(),
              validator: (value) {
                return widget.validator!(value);
              },
              focusNode: widget.focusNode,
              textAlignVertical: TextAlignVertical.bottom,
              cursorColor: AppColors.kFontColor.withOpacity(0.3),
              keyboardType: widget.textInputType,
              autocorrect: false,
              onChanged: widget.onChanged,
              onFieldSubmitted: widget.onFieldSubmitted,
              autovalidateMode: AutovalidateMode.disabled,
              enableSuggestions: false,
              textInputAction: widget.inputAction,
              inputFormatters: [
                widget.isPhoneField == true
                    ? FilteringTextInputFormatter.digitsOnly
                    : FilteringTextInputFormatter.singleLineFormatter
              ],
              maxLength: widget.isPhoneField == true ? 10 : null,
              enabled: widget.enabled,
              maxLines: widget.maxline,
              //decoration: null,
              decoration: _getNormalInputDecoration(),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _getNormalInputDecoration() {
    return InputDecoration(
      hintText: widget.hint,
      hintStyle: MavenTextStyles.nunitoRegular.copyWith(
        fontSize: 14,
        color: AppColors.kFontColor,
      ),
      isDense: true,
      contentPadding: EdgeInsets.only(
        left: 14,
        top: 10.5,
        bottom: 10.5,
        right: 14,
      ),
      suffixIcon: widget.suffixIcon,
      border: InputBorder.none,
      /*enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.r),
        ),
        borderSide: BorderSide(
          width: 1,
          color: AppColors.kDropDownBackColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
        borderSide: BorderSide(
          color: AppColors.kDropDownBackColor,
          style: BorderStyle.solid,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
        borderSide: BorderSide(
          color: AppColors.kDropDownBackColor,
          style: BorderStyle.solid,
        ),
      ),*/
    );
  }

  InputDecoration _getPasswordInputDecoration() {
    return InputDecoration(
      hintText: widget.hint,
      hintStyle: MavenTextStyles.nunitoRegular.copyWith(
        fontSize: 14,
        color: AppColors.ksignInColor,
      ),
      suffixIcon: GestureDetector(
        onTap: () {
          setState(() {
            isPasswordVisible = !isPasswordVisible;
          });
        },
        child: isPasswordVisible
            ? SvgPicture.asset(
                AppImages.icEyeOpen,
                fit: BoxFit.scaleDown,
              )
            : SvgPicture.asset(
                AppImages.icHidePass,
                fit: BoxFit.scaleDown,
              ),
      ),
      isDense: true,
      contentPadding: EdgeInsets.only(
        left: 14,
        top: 10.5,
        bottom: 10.5,
        right: 14,
      ),
      border: InputBorder.none,
      /*enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.r),
        ),
        borderSide: BorderSide(
          width: 1,
          color: AppColors.kDropDownBackColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
        borderSide: BorderSide(
          color: AppColors.kDropDownBackColor,
          style: BorderStyle.solid,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
        borderSide: BorderSide(
          color: AppColors.kDropDownBackColor,
          style: BorderStyle.solid,
        ),
      ),*/
    );
  }

  TextStyle _getTextStyle() {
    return MavenTextStyles.nunitoRegular.copyWith(
      fontSize: 14,
      color: AppColors.ksignInColor,
    );
  }
}
