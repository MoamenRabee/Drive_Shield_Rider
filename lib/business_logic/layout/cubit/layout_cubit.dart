import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rider/persentation/screens/home/home_screen.dart';
import 'package:rider/persentation/screens/orders/orders_screen.dart';
import 'package:rider/persentation/screens/profile/profile_screen.dart';

import '../../../data/constants/assets.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());
  static LayoutCubit get(BuildContext context) => BlocProvider.of(context);

  int bottomNavBarIndex = 0;

  void changeScreen(int index) {
    bottomNavBarIndex = index;
    emit(ChangeScreenState());
  }

  List<Widget> layoutBody = [
    const HomeScreen(),
    const OrdersScreen(),
    const ProfileScreen(),
  ];
}
