import 'package:rider/business_logic/auth/cubit/auth_cubit.dart';
import 'package:rider/business_logic/profile/cubit/profile_cubit.dart';
import 'package:rider/data/constants/assets.dart';
import 'package:rider/helpers/my_navigation.dart';
import 'package:rider/persentation/screens/auth/login_screen.dart';
import 'package:rider/persentation/screens/profile/profile_details_screen.dart';
import 'package:rider/persentation/screens/profile/settings_screen.dart';
import 'package:rider/persentation/widgets/my_scaffold.dart';
import 'package:rider/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      fullLogo: true,
      icon: true,
      height: 140,
      widgetTitle: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: SvgPicture.asset(
              AssetsSVG.profile,
              color: MyColors.mainColor,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            '${ProfileCubit.get(context).userModel?.name}',
            style: const TextStyle(
              fontSize: 15.0,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 2),
            decoration: const BoxDecoration(
              color: MyColors.gray,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 80,
                top: 24,
                left: 24,
                right: 24,
              ),
              child: Column(
                children: [
                  ProfileWidget(
                    title: 'معلومات الحساب',
                    svg: AssetsSVG.profileInfo,
                    onTap: () {
                      MyNavigator.navigateTo(context, const ProfileDetailsScreen());
                    },
                  ),
                  ProfileWidget(
                    title: 'الإعدادات',
                    svg: AssetsSVG.profile_3,
                    onTap: () {
                      MyNavigator.navigateTo(context, const SettingsScreen());
                    },
                  ),
                  ProfileWidget(
                    title: 'تسجيل الخروج',
                    svg: AssetsSVG.profile_4,
                    onTap: () {
                      AuthCubit.get(context).signOut(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  ProfileWidget({
    super.key,
    required this.title,
    required this.svg,
    this.onTap,
  });

  String title;
  String svg;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 322.0,
        height: 74.0,
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17.0),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9.0),
                color: MyColors.gray,
              ),
              child: Center(child: SvgPicture.asset(svg)),
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
