import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rider/theme/colors.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.text,
    this.textColor,
    this.color,
    this.width,
    this.height,
    this.onPressed,
    this.fontWeight,
    this.fontSize,
    this.borderRadius,
    this.isloading,
    this.elevation,
    this.gradient,
    this.isGradient,
  });

  double? width;
  double? height;
  double? fontSize;
  String text;
  Color? textColor;
  Color? color;
  FontWeight? fontWeight;
  void Function()? onPressed;
  BorderRadiusGeometry? borderRadius;
  bool? isloading = false;
  Gradient? gradient;
  bool? isGradient = false;
  double? elevation;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(6.0),
        // gradient: isGradient == false
        //     ? null
        //     : gradient ??
        //         const LinearGradient(
        //           begin: Alignment(0.0, -2.49),
        //           end: Alignment.bottomCenter,
        //           colors: [MyColors.redColor, MyColors.mainColor],
        //         ),
      ),
      width: width ?? 240,
      height: height ?? 40,
      child: ElevatedButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: onPressed == null
              ? color?.withOpacity(0.4) ?? MyColors.whiteColor.withOpacity(0.4)
              : isGradient == true
                  ? Colors.transparent
                  : onPressed == null
                      ? const Color(0x2b2b6db4)
                      : color,
          elevation: elevation ?? 0,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(6.0),
            side: const BorderSide(width: 0, color: Colors.transparent),
          ),
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
        ),
        child: AutoSizeText(
          text,
          style: TextStyle(
            color: onPressed == null ? Colors.white.withOpacity(0.5) : textColor,
            fontWeight: fontWeight,
            fontSize: fontSize,
          ),
          minFontSize: 7,
        ),
      ),
    );
  }
}

class CustomButtonLoading extends StatelessWidget {
  CustomButtonLoading({
    super.key,
    this.textColor,
    this.color,
    this.width,
    this.height,
    this.fontWeight,
    this.fontSize,
    this.borderRadius,
    this.isGradient,
    this.gradient,
    this.loadingPadding,
  });

  double? width;
  double? height;
  double? fontSize;
  Color? textColor;
  Color? color;
  FontWeight? fontWeight;
  BorderRadiusGeometry? borderRadius;
  bool? isGradient;
  Gradient? gradient;
  double? loadingPadding;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(6.0),
        gradient: isGradient == false
            ? null
            : gradient ??
                const LinearGradient(
                  begin: Alignment(0.0, -2.49),
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF98C1FF), Color(0xFF1552AE)],
                ),
      ),
      width: width ?? 240,
      height: height ?? 40,
      child: ElevatedButton(
        onPressed: null,
        style: TextButton.styleFrom(
          backgroundColor: isGradient == true ? Colors.transparent : color,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: 0,
            vertical: 0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(6.0),
            side: const BorderSide(width: 0, color: Colors.transparent),
          ),
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
        ),
        child: SizedBox(
          width: 15,
          height: 15,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: CircularProgressIndicator(
              color: textColor,
              strokeWidth: 4,
            ),
          ),
        ),
      ),
    );
  }
}
