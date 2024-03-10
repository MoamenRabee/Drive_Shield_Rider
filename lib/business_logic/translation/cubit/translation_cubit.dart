import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:rider/helpers/cache_helper.dart';
import 'package:rider/network/dio_helper.dart';

part 'translation_state.dart';

class TranslationCubit extends Cubit<TranslationState> {
  TranslationCubit() : super(TranslationInitial());

  static TranslationCubit get(BuildContext context) => BlocProvider.of(context);

  List<String> langs = ['ar', 'en'];
  String currentSelectedLang = CacheHelper.getString(key: "lang") ?? "en";

  bool isLoading = false;

  void changAppLang(BuildContext context, String lang) async {
    isLoading = true;
    emit(ChangAppLang());
    try {
      currentSelectedLang = lang;
      await CacheHelper.setString(key: "lang", value: lang).then((value) async {
        context.setLocale(Locale(lang));
        DioHelper.init();

        emit(ChangAppLang());
      });

      isLoading = false;

      emit(ChangAppLang());
    } catch (e) {
      isLoading = false;

      emit(ChangAppLang());
      log(e.toString());
    }
  }
}
