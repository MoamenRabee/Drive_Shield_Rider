import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gif_view/gif_view.dart';
import 'package:rider/helpers/my_navigation.dart';
import 'package:rider/models/user/user_model.dart';
import 'package:rider/persentation/screens/layout/layout_screen.dart';
import 'package:rider/persentation/screens/onboarding/onboarding_screen.dart';
import 'package:rider/theme/colors.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key, required this.userModel});

  UserModel? userModel;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GifController controller = GifController();

  @override
  void initState() {
    controller = GifController(
      loop: false,
      autoPlay: true,
      onFinish: () {
        MyNavigator.navigateTo(
          context,
          InitialScreen(
            userModel: widget.userModel,
          ),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.mainColor,
      body: SafeArea(
        child: Center(
          child: GifView.asset(
            'assets/images/intro.gif',
            controller: controller,
            height: 250,
            width: 250,
            frameRate: 30,
            repeat: ImageRepeat.noRepeat,
          ),
        ),
      ),
    );
  }
}

class InitialScreen extends StatelessWidget {
  InitialScreen({super.key, required this.userModel});

  UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    if (userModel == null) {
      return const OnBoardingScreen();
    } else {
      return const LayoutScreen();
    }
  }
}
