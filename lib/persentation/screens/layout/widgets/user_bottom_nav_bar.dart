import 'package:rider/business_logic/layout/cubit/layout_cubit.dart';
import 'package:rider/data/constants/assets.dart';
import 'package:rider/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavBarItem {
  late String title;
  late String icon;
  late int id;

  BottomNavBarItem({required this.title, required this.icon, required this.id});

  static List<BottomNavBarItem> navBar = [
    BottomNavBarItem(title: 'الرئيسية', icon: AssetsSVG.home, id: 0),
    BottomNavBarItem(title: 'الطلبيات', icon: AssetsSVG.reports, id: 1),
    BottomNavBarItem(title: 'حسابي', icon: AssetsSVG.profile, id: 2),
  ];
}

Widget bottomNavBar(BuildContext context, int pageIndex) {
  LayoutCubit cubit = LayoutCubit.get(context);
  return Container(
    width: double.infinity,
    height: 80,
    decoration: BoxDecoration(
      color: MyColors.black,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      border: Border.all(
        width: 1,
        color: Colors.grey[300]!,
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...BottomNavBarItem.navBar.map(
          (e) => bottomNavBarItem(
            context: context,
            pageIndex: cubit.bottomNavBarIndex,
            barItem: e,
          ),
        ),
      ],
    ),
  );
}

Widget bottomNavBarItem({
  required BuildContext context,
  required int pageIndex,
  required BottomNavBarItem barItem,
}) {
  return Expanded(
    child: GestureDetector(
      onTap: () {
        LayoutCubit.get(context).changeScreen(barItem.id);
      },
      child: CircleAvatar(
        radius: 27,
        backgroundColor: pageIndex == barItem.id ? Colors.white.withOpacity(0.08) : Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 4),
            SvgPicture.asset(
              barItem.icon,
              width: 20,
              color: pageIndex == barItem.id ? MyColors.redBottomNavBarColor : Colors.grey[300],
            ),
            const SizedBox(height: 1),
            Text(
              barItem.title,
              style: TextStyle(
                fontSize: 8,
                color: pageIndex == barItem.id ? MyColors.redBottomNavBarColor : Colors.grey[300],
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
