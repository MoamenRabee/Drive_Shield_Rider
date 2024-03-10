import 'package:rider/data/constants/assets.dart';
import 'package:rider/helpers/my_navigation.dart';
import 'package:rider/persentation/widgets/my_scaffold.dart';
import 'package:rider/persentation/widgets/textFormField.dart';
import 'package:rider/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      scaffoldColor: MyColors.gray,
      title: 'الإشعارات',
      iconback: true,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              _card(),
              _card(),
              _card(),
              _card(),
              _card(),
            ],
          ),
        ),
      ),
    );
  }

  Container _card() {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13.0),
        color: Colors.white,
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            AssetsSVG.logoIcon,
            width: 40,
          ),
          const SizedBox(width: 10),
          const Text(
            'تم الموفقة على الطلبية الجديدة',
            style: TextStyle(
              fontSize: 10.0,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
