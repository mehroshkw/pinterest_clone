import 'package:flutter/material.dart';

import '../../utils/app_colours.dart';

class AppTextField extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String hint;
  final TextInputType textInputType;
  final bool isError;
  final TextInputAction textInputAction;
  final bool isObscure;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final bool readOnly;
  final Function()? onSuffixClick;

  const AppTextField(
      {required this.hint,
      required this.textInputType,
      required this.isError,
      this.controller,
      this.onChanged,
      this.isObscure = false,
      this.readOnly = false,
      this.suffixIcon,
      this.onSuffixClick,
      this.prefixIcon,
      this.textInputAction = TextInputAction.next});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 45,
        alignment: Alignment.center,
        // padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.only(bottom: 10, top: 10),
        decoration: BoxDecoration(
          color: AppColours.colorOnBorder.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),

          border: Border.all(
            width: 0.3,color: isError ? AppColours.colorError : Colors.transparent,),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: TextFormField(
              obscureText: isObscure,
              controller: controller,
              readOnly: readOnly,
              onChanged: onChanged,
              keyboardType: textInputType,
              textInputAction: textInputAction,
              style: const TextStyle(
                  color: AppColours.onScaffoldColor, fontFamily: AppFonts.NHaasGroteskRegular, fontSize: 14),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  prefixIcon: prefixIcon,
                  hintText: hint,
                  hintStyle: const TextStyle(
                      color: AppColours.colorPrimaryVariant, fontFamily: AppFonts.helveticaRegular, fontSize: 16)),
            )),
            suffixIcon != null
                ? GestureDetector(
                    onTap: () => onSuffixClick?.call(),
                    child: Padding(padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5), child: suffixIcon!))
                : const SizedBox()
          ],
        ));
  }
}

