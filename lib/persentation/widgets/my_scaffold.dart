import 'package:rider/data/constants/assets.dart';
import 'package:rider/helpers/my_navigation.dart';
import 'package:rider/persentation/screens/notifications/notifications_screen.dart';
import 'package:rider/persentation/widgets/header.dart';
import 'package:rider/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyScaffold extends StatelessWidget {
  MyScaffold({
    super.key,
    this.title,
    this.widgetTitle,
    this.body,
    this.iconback,
    this.scaffoldColor,
    this.fullLogo,
    this.icon,
    this.height,
  });

  String? title;
  Widget? widgetTitle;
  Widget? body;
  bool? iconback;
  Color? scaffoldColor;
  bool? fullLogo;
  bool? icon;
  double? height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.mainColor,
      extendBodyBehindAppBar: true,
      // extendBody: true,
      body: Column(
        children: [
          Container(
            height: height ?? 150,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: MyColors.mainColor,
              borderRadius: BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(50),
                bottomStart: Radius.circular(50),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 25),
                        if (icon != false)
                          if (iconback != true)
                            GestureDetector(
                              onTap: () {
                                MyNavigator.navigateTo(context, const NotificationScreen());
                              },
                              child: SvgPicture.asset(
                                AssetsSVG.notification,
                                height: 30,
                                width: 30,
                              ),
                            )
                          else
                            IconButton(
                              onPressed: () {
                                MyNavigator.back(context);
                              },
                              icon: Transform.flip(flipX: context.locale.languageCode == 'ar' ? true : false, child: SvgPicture.asset(AssetsSVG.next)),
                            ),
                        const Spacer(),
                        fullLogo == true
                            ? SvgPicture.asset(
                                AssetsSVG.logoSvg,
                                width: 40,
                                height: 35,
                                color: Colors.white,
                              )
                            : SvgPicture.asset(
                                AssetsSVG.logoIcon,
                                width: 40,
                                height: 40,
                                color: Colors.white,
                              ),
                        const SizedBox(width: 20),
                      ],
                    ),
                  ),
                  if (title != null)
                    Text(
                      title.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (widgetTitle != null)
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: widgetTitle,
                    ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ClipPath(
              clipper: MyClipper(radius: 50),
              child: Container(
                padding: const EdgeInsets.only(top: 50),
                color: MyColors.whiteColor,
                width: MediaQuery.of(context).size.width,
                child: body ?? const SizedBox(),
              ),
            ),
          ),
          // Expanded(child: ),
        ],
      ),
    );
  }
}
