import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rider/business_logic/orders/cubit/orders_cubit.dart';
import 'package:rider/business_logic/profile/cubit/profile_cubit.dart';
import 'package:rider/data/constants/api_constants.dart';
import 'package:rider/data/constants/assets.dart';
import 'package:rider/data/constants/constants.dart';
import 'package:rider/functions/functions.dart';
import 'package:rider/functions/select_files.dart';
import 'package:rider/helpers/my_navigation.dart';
import 'package:rider/models/order/order_model.dart';
import 'package:rider/models/order_item/order_item_model.dart';
import 'package:rider/persentation/screens/auth/reset_password_screen.dart';
import 'package:rider/persentation/screens/notifications/notifications_screen.dart';
import 'package:rider/persentation/screens/orders/order_details_screen.dart';
import 'package:rider/persentation/widgets/Loading_widget.dart';
import 'package:rider/persentation/widgets/buttons.dart';
import 'package:rider/persentation/widgets/image_loading.dart';
import 'package:rider/persentation/widgets/lang_widget.dart';
import 'package:rider/persentation/widgets/my_scaffold.dart';
import 'package:rider/persentation/widgets/textFormField.dart';
import 'package:rider/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    OrdersCubit.get(context).getOrdersNew();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      fullLogo: true,
      icon: true,
      height: 140,
      widgetTitle: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: SvgPicture.asset(
              AssetsSVG.profile,
              color: MyColors.mainColor,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            '${ProfileCubit.get(context).userModel?.name}',
            style: const TextStyle(
              fontSize: 15.0,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 2),
            decoration: const BoxDecoration(
              color: MyColors.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child: BlocBuilder<OrdersCubit, OrdersState>(
              builder: (context, state) {
                return OrdersCubit.get(context).isLoadingNewData
                    ? MyLoadingTransperant()
                    : SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(bottom: 80, top: 40),
                        child: Column(
                          children: [
                            ...OrdersCubit.get(context).newOrders.map((order) {
                              return _orderCard(order, context);
                            }),
                          ],
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }

  BlocBuilder _orderCard(OrderModel order, BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            MyNavigator.navigateTo(
              context,
              OrderDetailsScreen(
                orderModel: order,
              ),
            );
          },
          child: Container(
            width: 346.0,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: MyColors.scaffoldColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'طلبية جديدة',
                    style: TextStyle(
                      fontSize: 19.0,
                      color: MyColors.mainColor,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'الطلبية',
                      style: TextStyle(
                        fontSize: 11.0,
                        color: MyColors.mainColor,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      order.reference,
                      style: const TextStyle(
                        fontSize: 11.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${order.customer?.name}',
                  style: const TextStyle(
                    fontSize: 13.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'تاريخ الإصدار',
                      style: TextStyle(
                        fontSize: 11.0,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      formatDate(context, order.createdAt),
                      style: const TextStyle(
                        fontSize: 11.0,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'الفرع',
                      style: TextStyle(
                        fontSize: 11.0,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      'مش راجع',
                      style: TextStyle(
                        fontSize: 11.0,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 20,
                  color: MyColors.black,
                  thickness: 0.2,
                ),
                ...List.generate(order.orderItems?.length ?? 0, (index) {
                  return _productCard(order.orderItems![index]);
                }),
                const SizedBox(height: 20),
                // if (order.shippingStatus == null)
                Center(
                  child: OrdersCubit.get(context).isLoadingActionreceive && state is OrdersActionLoading && state.id == order.id
                      ? CustomButtonLoading(
                          color: MyColors.green,
                          textColor: Colors.white,
                          width: 220,
                          height: 33,
                          borderRadius: BorderRadius.circular(30),
                          isGradient: false,
                        )
                      : CustomButton(
                          onPressed: () async {
                            if (order.shippingStatus == null) {
                              await OrdersCubit.get(context).updateOrder(
                                context: context,
                                orderModel: order,
                                status: OrderShoppingStatus.received,
                              );
                            } else if (order.shippingStatus == OrderShoppingStatus.received) {
                              await OrdersCubit.get(context).updateOrder(
                                context: context,
                                orderModel: order,
                                status: OrderShoppingStatus.processing,
                              );
                            } else if (order.shippingStatus == OrderShoppingStatus.processing) {
                              await OrdersCubit.get(context).updateOrder(
                                context: context,
                                orderModel: order,
                                status: OrderShoppingStatus.delivery,
                              );
                            } else if (order.shippingStatus == OrderShoppingStatus.delivery) {
                              selectImage(context).then((value) async {
                                if (value != null) {
                                  await OrdersCubit.get(context).updateOrder(
                                    context: context,
                                    orderModel: order,
                                    status: OrderShoppingStatus.delivered,
                                    file: value,
                                  );
                                }
                              });
                            }
                          },
                          text: order.shippingStatus == null
                              ? 'استلم الطلبية'
                              : order.shippingStatus == OrderShoppingStatus.received
                                  ? 'معالجة الطلبية'
                                  : order.shippingStatus == OrderShoppingStatus.processing
                                      ? 'جاري التوصيل'
                                      : 'تم التوصيل',
                          color: MyColors.green,
                          textColor: Colors.white,
                          width: 220,
                          height: 33,
                          borderRadius: BorderRadius.circular(30),
                          isGradient: false,
                        ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Container _productCard(OrderItemModel orderItemModel) {
    return Container(
      width: 377.0,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.only(bottom: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17.0),
        // color: MyColors.gray,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 71.0,
            height: 70.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: loadingImage(
              image: ApiConstants.stoarge + orderItemModel.product.picture,
              borderRadius: BorderRadius.circular(14.0),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.locale.languageCode == 'ar' ? orderItemModel.product.nameAr : orderItemModel.product.nameEn,
                  style: const TextStyle(
                    fontSize: 11.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                ),
                Text(
                  orderItemModel.product.description,
                  style: const TextStyle(
                    fontSize: 11.0,
                    color: Color(0xFF7B7B7B),
                  ),
                  maxLines: 1,
                ),
                Text(
                  orderItemModel.total.toString(),
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Text(
            double.parse(orderItemModel.quantity).toInt().toString(),
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
