import 'package:firebase_core/firebase_core.dart';
import 'package:rider/business_logic/auth/cubit/auth_cubit.dart';
import 'package:rider/business_logic/layout/cubit/layout_cubit.dart';
import 'package:rider/business_logic/orders/cubit/orders_cubit.dart';
import 'package:rider/business_logic/profile/cubit/profile_cubit.dart';
import 'package:rider/business_logic/reset_password/cubit/reset_password_cubit.dart';
import 'package:rider/business_logic/translation/cubit/translation_cubit.dart';
import 'package:rider/firebase_options.dart';
import 'package:rider/helpers/cache_helper.dart';
import 'package:rider/models/user/user_model.dart';
import 'package:rider/network/dio_helper.dart';
import 'package:rider/network/services/profile_service.dart';
import 'package:rider/persentation/screens/onboarding/onboarding_screen.dart';
import 'package:rider/persentation/screens/splash/splash_screen.dart';
import 'package:rider/theme/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui' as ui;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  UserModel? userModel = await ProfileServices.getProfile();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      startLocale: const Locale('ar'),
      path: 'assets/translations',
      fallbackLocale: const Locale('ar'),
      child: MyApp(userModel: userModel),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.userModel});

  UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => LayoutCubit()),
        BlocProvider(create: (BuildContext context) => AuthCubit()),
        BlocProvider(create: (BuildContext context) => ResetPasswordCubit()),
        BlocProvider(create: (BuildContext context) => ProfileCubit()),
        BlocProvider(create: (BuildContext context) => TranslationCubit()),
        BlocProvider(create: (BuildContext context) => OrdersCubit()),
      ],
      child: BlocBuilder<TranslationCubit, TranslationState>(
        builder: (context, state) {
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            title: 'Drive Shield',
            debugShowCheckedModeBanner: false,
            theme: MyTheme.themeData(context),
            home: SplashScreen(userModel: userModel),
            // builder: (context, child) {
            //   return Directionality(
            //     textDirection: ui.TextDirection.rtl,
            //     child: child!,
            //   );
            // },
          );
        },
      ),
    );
  }
}
