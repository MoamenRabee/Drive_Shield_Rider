import 'package:rider/helpers/cache_helper.dart';

class Constants {
  static double keyboardHeight = 0;
  static String currentLanguage = CacheHelper.getString(key: "lang") ?? 'en';
  static String rememberMe = CacheHelper.getString(key: "remember_me") ?? "";
  static String accessToken = CacheHelper.getString(key: "access_token") ?? "";
  static String countryCode = "+966";
  static List<String> newsFavorates = CacheHelper.getList(key: "news_favorates") ?? [];
}

class OrderShoppingStatus {
  static String received = 'Received';
  static String processing = 'Processing';
  static String delivery = 'Delivery';
  static String delivered = 'Delivered';
}

abstract class Fonts {
  static const String arabic = 'NotoSansArabic';
}
