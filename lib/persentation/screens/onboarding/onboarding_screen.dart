import 'package:rider/data/constants/assets.dart';
import 'package:rider/helpers/my_navigation.dart';
import 'package:rider/persentation/screens/auth/login_screen.dart';
import 'package:rider/persentation/widgets/buttons.dart';
import 'package:rider/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.scaffoldColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  width: 400,
                  height: 300,
                  child: SvgPicture.asset(
                    AssetsSVG.onbording,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'انضم الي مسؤلي مبيعات',
                    style: TextStyle(fontSize: 25.0, color: Colors.black, fontWeight: FontWeight.bold, height: 3),
                  ),
                  Text(
                    'درايف شيلد',
                    style: TextStyle(fontSize: 28.0, color: MyColors.mainColor, fontWeight: FontWeight.w200, height: 1),
                  ),
                ],
              ),
              const SizedBox(height: 100),
              Center(
                child: GestureDetector(
                  onTap: () {
                    MyNavigator.navigateOffAll(context, LoginScreen());
                  },
                  child: CircleAvatar(
                    backgroundColor: MyColors.mainColor,
                    radius: 30,
                    child: Transform.flip(flipX: true, child: SvgPicture.asset(AssetsSVG.next)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
