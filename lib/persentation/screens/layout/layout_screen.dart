import 'package:easy_localization/easy_localization.dart';
import 'package:rider/business_logic/layout/cubit/layout_cubit.dart';
import 'package:rider/business_logic/profile/cubit/profile_cubit.dart';
import 'package:rider/persentation/screens/layout/widgets/user_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui' as ui;

import 'package:rider/persentation/widgets/Loading_widget.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  @override
  void initState() {
    ProfileCubit.get(context).getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LayoutCubit cubit = LayoutCubit.get(context);
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return BlocBuilder<LayoutCubit, LayoutState>(
          builder: (context, state) {
            return Directionality(
              textDirection: context.locale.languageCode == 'en' ? ui.TextDirection.ltr : ui.TextDirection.rtl,
              child: Scaffold(
                extendBody: true,
                body: ProfileCubit.get(context).isLoading || ProfileCubit.get(context).userModel == null ? MyLoadingTransperant() : cubit.layoutBody[cubit.bottomNavBarIndex],
                bottomNavigationBar: ProfileCubit.get(context).isLoading || ProfileCubit.get(context).userModel == null ? null : bottomNavBar(context, cubit.bottomNavBarIndex),
              ),
            );
          },
        );
      },
    );
  }
}
