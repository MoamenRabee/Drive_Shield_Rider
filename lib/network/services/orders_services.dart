import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rider/data/constants/api_constants.dart';
import 'package:rider/models/order/order_model.dart';
import 'package:rider/network/dio_helper.dart';

class OrdersServices {
  static String endPoint = EndPoints.orders;

  static List<OrderModel> dataNew = [];
  static Future<List<OrderModel>> getDataNew() async {
    dataNew.clear();
    try {
      DioHelper.dio.options.headers.addAll({"per_page": 1000});
      var result = await DioHelper.get(
        path: endPoint,
        queryParameters: {
          "filter[status]": 'New' //New,Completed
        },
      );
      DioHelper.dio.options.headers.remove('per_page');

      if (result.statusCode == 200) {
        log('Get $endPoint Success');
        for (var element in result.data['data']['data']) {
          dataNew.add(OrderModel.fromJson(element));
        }
        return dataNew;
      } else {
        log('Unable To Get $endPoint');
        return dataNew;
      }
    } catch (e) {
      log('$e');
      return dataNew;
    }
  }

  static List<OrderModel> dataCompleted = [];
  static Future<List<OrderModel>> getDataCompleted() async {
    dataCompleted.clear();
    try {
      DioHelper.dio.options.headers.addAll({"per_page": 1000});
      var result = await DioHelper.get(
        path: endPoint,
        queryParameters: {
          "filter[status]": 'Completed' //New,Completed
        },
      );
      DioHelper.dio.options.headers.remove('per_page');

      if (result.statusCode == 200) {
        log('Get $endPoint Success');
        for (var element in result.data['data']['data']) {
          dataCompleted.add(OrderModel.fromJson(element));
        }
        return dataCompleted;
      } else {
        log('Unable To Get $endPoint');
        return dataCompleted;
      }
    } catch (e) {
      log('$e');
      return dataCompleted;
    }
  }

  static Future<Response?> updateOrder(FormData payload, int id) async {
    try {
      var result = await DioHelper.post(path: 'order/$id', data: payload);

      if (result.statusCode == 200) {
        log('Add $endPoint  Success');
        return result;
      } else {
        log('Unable To Add $endPoint');
      }

      return result;
    } catch (e) {
      log('$e');
    }
    return null;
  }
}
