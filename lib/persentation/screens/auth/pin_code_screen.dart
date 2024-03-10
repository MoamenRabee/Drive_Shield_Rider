import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rider/business_logic/reset_password/cubit/reset_password_cubit.dart';
import 'package:rider/data/constants/assets.dart';
import 'package:rider/helpers/my_navigation.dart';
import 'package:rider/persentation/widgets/buttons.dart';

import 'dart:ui' as ui;

import 'package:rider/theme/colors.dart';

class PinCodeScreen extends StatefulWidget {
  PinCodeScreen({super.key, required this.phone});

  final String phone;

  @override
  State<PinCodeScreen> createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  String smsOTP = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.scaffoldColor,
      appBar: AppBar(
        backgroundColor: MyColors.scaffoldColor,
        leading: IconButton(
          onPressed: () {
            MyNavigator.back(context);
          },
          icon: SvgPicture.asset(
            AssetsSVG.next,
            color: MyColors.mainColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(AssetsSVG.resetPassword),
              const SizedBox(height: 10),
              Text(
                'Enter the temporary password'.tr(),
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              Directionality(
                textDirection: ui.TextDirection.ltr,
                child: SizedBox(
                  width: 280,
                  child: PinCodeTextField(
                    appContext: context,
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    cursorColor: Colors.white,
                    pinTheme: PinTheme(
                      errorBorderColor: MyColors.redColor,
                      inactiveColor: Colors.grey,
                      inactiveFillColor: Colors.transparent,
                      activeColor: Colors.grey,
                      selectedFillColor: Colors.grey,
                      selectedColor: Colors.grey,
                      activeFillColor: Colors.white,
                      disabledColor: MyColors.mainColor,
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(11),
                      fieldHeight: 40,
                      fieldWidth: 40,
                      borderWidth: 0.5,
                      inactiveBorderWidth: 0.6,
                      errorBorderWidth: 0.6,
                      activeBorderWidth: 0.6,
                      disabledBorderWidth: 0.6,
                      selectedBorderWidth: 0.6,
                    ),

                    keyboardType: TextInputType.number,
                    animationDuration: const Duration(milliseconds: 200),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,
                    //errorAnimationController: errorController,
                    controller: TextEditingController(),
                    onCompleted: (val) {
                      setState(() {
                        smsOTP = val;
                      });
                    },
                    onChanged: (value) {
                      log(value);
                      setState(() {});
                    },
                    beforeTextPaste: (text) {
                      log("Allowing to paste $text");
                      return true;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                  builder: (context, state) {
                    return ResetPasswordCubit.get(context).isLoading
                        ? CustomButtonLoading(
                            color: MyColors.mainColor,
                            textColor: MyColors.whiteColor,
                            fontSize: 25,
                            height: 57,
                            width: 300,
                            borderRadius: BorderRadius.circular(30),
                          )
                        : CustomButton(
                            onPressed: (smsOTP.isEmpty)
                                ? null
                                : () async {
                                    await ResetPasswordCubit.get(context).confirmPhoneNumberAndResetPassword(context: context, code: smsOTP, phone: widget.phone);
                                  },
                            text: 'Send',
                            color: MyColors.mainColor,
                            textColor: MyColors.whiteColor,
                            fontSize: 17,
                            height: 57,
                            width: 300,
                            borderRadius: BorderRadius.circular(30),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
