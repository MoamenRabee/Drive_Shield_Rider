import 'package:rider/business_logic/profile/cubit/profile_cubit.dart';
import 'package:rider/data/constants/assets.dart';
import 'package:rider/helpers/my_navigation.dart';
import 'package:rider/persentation/widgets/my_scaffold.dart';
import 'package:rider/persentation/widgets/textFormField.dart';
import 'package:rider/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      scaffoldColor: MyColors.gray,
      title: 'تفاصيل الحساب',
      iconback: true,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SizedBox(
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'الاسم',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                CustomTextFormField(
                  text: '${ProfileCubit.get(context).userModel?.name}',
                  controller: TextEditingController(),
                  isFilld: true,
                  color: MyColors.whiteColor,
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(11),
                ),
                const SizedBox(height: 10),
                const Text(
                  'رقم الجوال',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                CustomTextFormField(
                  text: '${ProfileCubit.get(context).userModel?.phoneNumber}',
                  controller: TextEditingController(),
                  isFilld: true,
                  color: MyColors.whiteColor,
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(11),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
