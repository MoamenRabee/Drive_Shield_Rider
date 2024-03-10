import 'dart:developer';
import 'dart:io';

import 'package:rider/data/constants/constants.dart';
import 'package:rider/functions/functions.dart';
import 'package:rider/functions/select_files.dart';
import 'package:rider/helpers/my_navigation.dart';
import 'package:rider/models/branche/branche_model.dart';
import 'package:rider/models/order/order_model.dart';
import 'package:rider/models/selected_products/selected_products.dart';
import 'package:rider/network/services/orders_services.dart';
import 'package:rider/theme/colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial());

  static OrdersCubit get(BuildContext context) => BlocProvider.of(context);
  BrancheModel? selectedBranch;

  void selectBranch(BrancheModel brancheModel) {
    selectedBranch = brancheModel;
    emit(SelectBranch());
  }

  bool isLoadingNewData = false;
  bool isLoadingCompletedData = false;
  bool isLoadingActionreceive = false;
  bool isLoadingDelete = false;

  List<OrderModel> newOrders = [];
  List<OrderModel> completedOrders = [];

  Future<void> getOrdersNew() async {
    try {
      isLoadingNewData = true;
      emit(OrdersGetLoading());
      newOrders = await OrdersServices.getDataNew();
      log('newOrders : ${newOrders.length}');

      isLoadingNewData = false;
      emit(OrdersGetSuccess());
    } catch (e) {
      log('$e');
      isLoadingNewData = false;
      emit(OrdersGetError());
    }
  }

  Future<void> getOrdersCompleted() async {
    try {
      isLoadingCompletedData = true;
      emit(OrdersGetLoading());
      completedOrders = await OrdersServices.getDataCompleted();

      isLoadingCompletedData = false;
      emit(OrdersGetSuccess());
    } catch (e) {
      log('$e');
      isLoadingCompletedData = false;
      emit(OrdersGetError());
    }
  }

  Future<void> updateOrder({
    required BuildContext context,
    required OrderModel orderModel,
    required String status,
    File? file,
  }) async {
    try {
      isLoadingActionreceive = true;
      emit(OrdersActionLoading(orderModel.id));

      var form = FormData.fromMap({
        "status": status,
        if (file != null) "confirmation_image": await MultipartFile.fromFile(file.path),
      });

      log(form.files.toString());

      Response? response = await OrdersServices.updateOrder(form, orderModel.id);

      if (response?.statusCode == 200) {
        await getOrdersNew();
        orderModel.status = status;
      } else {
        log('${response?.data['msg'].toString()}');
        // ignore: use_build_context_synchronously
        showMessage(context: context, message: '${response?.data['msg'].toString()}', color: MyColors.mainColor);
      }

      isLoadingActionreceive = false;
      emit(OrdersActionSuccess());
    } catch (e) {
      log('$e');
      isLoadingActionreceive = false;
      emit(OrdersActionError());
    }
  }
}
