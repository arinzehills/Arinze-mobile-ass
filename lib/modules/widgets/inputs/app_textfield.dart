import 'package:flutter/material.dart';
import 'package:mobile_assessment/common/shared_styles.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final Widget? suffix;
  final bool isPassword;
  final Key? textFieldKey;
  final int? maxLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final String? initialValue;
  final bool isDisabled;
  final Widget? suffixIcon;
  final bool readOnly;
  final TextEditingController? controller;

  const CustomTextField({
    Key? key,
    this.textFieldKey,
    required this.hintText,
    required this.labelText,
    this.suffixIcon,
    this.suffix,
    this.keyboardType,
    this.controller,
    this.isPassword = false,
    this.maxLines,
    this.maxLength,
    this.onSaved,
    this.validator,
    this.onChanged,
    this.initialValue,
    this.isDisabled = false,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isTablet = size(context).width > 600;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: controller != null
          ? TextFormField(
              key: textFieldKey,
              autovalidateMode: AutovalidateMode.always,
              controller: controller,
              enabled: !isDisabled,
              obscureText: isPassword,
              validator: validator,
              onSaved: onSaved!,
              onChanged: onChanged,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                height: isTablet ? 2.9 : 1.7,
              ),
              cursorColor: Theme.of(context).highlightColor,
              maxLines: isPassword ? 1 : maxLines,
              maxLength: maxLength,
              keyboardType: keyboardType,
              readOnly: readOnly,
              decoration: textFieldDecoration.copyWith(
                labelText: labelText,
                suffix: suffix,
                suffixIcon: suffixIcon,
                contentPadding: isTablet ? EdgeInsets.all(14.0) : null,

                // disabledBorder: UnderlineInputBorder(
                //     borderSide:
                //         BorderSide(color: Theme.of(context).primaryColor)),
                // enabledBorder: UnderlineInputBorder(
                //     borderSide:
                //         BorderSide(color: Theme.of(context).primaryColor)),
              ),
            )
          : TextFormField(
              key: textFieldKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              initialValue: initialValue ?? '',
              enabled: !isDisabled,
              obscureText: isPassword,
              validator: validator,
              onSaved: onSaved,
              onChanged: onChanged,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                height: isTablet ? 2.9 : 1.7,
              ),
              cursorColor: Theme.of(context).primaryColor,
              maxLines: isPassword ? 1 : maxLines,
              maxLength: maxLength,
              keyboardType: keyboardType ?? TextInputType.text,
              readOnly: readOnly,
              decoration: textFieldDecoration.copyWith(
                labelText: labelText,
                floatingLabelStyle:
                    TextStyle(color: Theme.of(context).primaryColor),
                suffix: suffix,
                suffixIcon: suffixIcon,
                contentPadding: isTablet ? EdgeInsets.all(14.0) : null,

                // focusedBorder: UnderlineInputBorder(
                //     borderSide:
                //         BorderSide(color: Theme.of(context).primaryColor)),
                // disabledBorder: const UnderlineInputBorder(
                //     borderSide: BorderSide(color: Colors.grey)),
                // enabledBorder: const UnderlineInputBorder(
                //     borderSide: BorderSide(color: Colors.black)),
              ),
            ),
    );
  }
}
