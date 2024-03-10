import 'package:rider/business_logic/profile/cubit/profile_cubit.dart';
import 'package:rider/data/constants/assets.dart';
import 'package:rider/helpers/my_navigation.dart';
import 'package:rider/persentation/screens/auth/reset_password_screen.dart';
import 'package:rider/persentation/widgets/buttons.dart';
import 'package:rider/persentation/widgets/lang_widget.dart';
import 'package:rider/persentation/widgets/my_scaffold.dart';
import 'package:rider/persentation/widgets/textFormField.dart';
import 'package:rider/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  TextEditingController password1Controller = TextEditingController();
  TextEditingController password2Controller = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'Password'.tr(),
      iconback: true,
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextFormField(
                text: 'New Password'.tr(),
                controller: password1Controller,
                borderRadius: BorderRadius.circular(17),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                borderColor: MyColors.scaffoldColor.withOpacity(0.8),
                isFilld: true,
                color: MyColors.scaffoldColor.withOpacity(0.8),
                hintColor: Colors.black.withOpacity(0.5),
                textColor: Colors.black,
                validator: (val) {
                  if (val!.isEmpty || val.length < 8) {
                    return 'Please enter a password of 8 characters'.tr();
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                text: 'Confirm Password'.tr(),
                controller: password2Controller,
                borderRadius: BorderRadius.circular(17),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                borderColor: MyColors.scaffoldColor.withOpacity(0.8),
                isFilld: true,
                color: MyColors.scaffoldColor.withOpacity(0.8),
                hintColor: Colors.black.withOpacity(0.5),
                textColor: Colors.black,
                validator: (val) {
                  if (val!.isEmpty || val.length < 8) {
                    return 'Please enter a password of 8 characters'.tr();
                  }
                  if (val != password1Controller.text) {
                    return 'The two passwords are not the same'.tr();
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              Center(
                child: BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    return ProfileCubit.get(context).isLoadingChangePassword
                        ? CustomButtonLoading(
                            color: MyColors.mainColor,
                            textColor: MyColors.whiteColor,
                            fontSize: 25,
                            height: 50,
                            width: 300,
                            borderRadius: BorderRadius.circular(23),
                          )
                        : CustomButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                ProfileCubit.get(context).changePassword(password2Controller.text, context);
                              }
                            },
                            text: 'Change'.tr(),
                            color: MyColors.mainColor,
                            textColor: MyColors.whiteColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            height: 50,
                            width: 300,
                            borderRadius: BorderRadius.circular(23),
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
