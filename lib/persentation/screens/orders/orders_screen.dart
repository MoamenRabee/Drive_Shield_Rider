import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rider/business_logic/orders/cubit/orders_cubit.dart';
import 'package:rider/data/constants/assets.dart';
import 'package:rider/data/constants/constants.dart';
import 'package:rider/functions/functions.dart';
import 'package:rider/functions/select_files.dart';
import 'package:rider/helpers/my_navigation.dart';
import 'package:rider/models/order/order_model.dart';
import 'package:rider/persentation/screens/orders/order_details_screen.dart';
import 'package:rider/persentation/screens/profile/profile_details_screen.dart';
import 'package:rider/persentation/widgets/Loading_widget.dart';
import 'package:rider/persentation/widgets/buttons.dart';
import 'package:rider/persentation/widgets/my_scaffold.dart';
import 'package:rider/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool newOrderSelected = true;

  @override
  void initState() {
    if (newOrderSelected) {
      OrdersCubit.get(context).getOrdersNew();
    } else {
      OrdersCubit.get(context).getOrdersCompleted();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      fullLogo: true,
      icon: true,
      title: 'الطلبيات',
      height: 140,
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 0),
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
                return Column(
                  children: [
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 10,
                      runSpacing: 20,
                      children: [
                        _tapOrders(
                          title: 'جديد',
                          isActive: newOrderSelected == true,
                          onTap: () {
                            setState(() {
                              newOrderSelected = true;
                            });
                            OrdersCubit.get(context).getOrdersNew();
                          },
                        ),
                        _tapOrders(
                          title: 'قديم',
                          isActive: newOrderSelected == false,
                          onTap: () {
                            setState(() {
                              newOrderSelected = false;
                            });
                            OrdersCubit.get(context).getOrdersCompleted();
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: OrdersCubit.get(context).isLoadingNewData || OrdersCubit.get(context).isLoadingCompletedData
                          ? MyLoadingTransperant()
                          : Align(
                              alignment: Alignment.topCenter,
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                padding: const EdgeInsets.only(
                                  bottom: 80,
                                ),
                                itemBuilder: (context, index) {
                                  return CardOrderWidget(
                                    orderModel: newOrderSelected == true ? OrdersCubit.get(context).newOrders[index] : OrdersCubit.get(context).completedOrders[index],
                                  );
                                },
                                itemCount: newOrderSelected == true ? OrdersCubit.get(context).newOrders.length : OrdersCubit.get(context).completedOrders.length,
                              ),
                            ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _tapOrders({
    required String title,
    required bool isActive,
    required Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 132.0,
        height: 40.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: isActive ? MyColors.mainColor : MyColors.whiteColor,
          border: isActive
              ? null
              : Border.all(
                  width: 0.5,
                  color: MyColors.mainColor,
                ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
              color: isActive == false ? MyColors.mainColor : MyColors.whiteColor,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class CardOrderWidget extends StatelessWidget {
  CardOrderWidget({
    super.key,
    required this.orderModel,
  });

  OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MyNavigator.navigateTo(
          context,
          OrderDetailsScreen(
            orderModel: orderModel,
          ),
        );
      },
      child: Container(
        // width: 346.0,
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: MyColors.scaffoldColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'الطلبية',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: MyColors.mainColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  orderModel.reference,
                  style: const TextStyle(
                    fontSize: 10.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Text(
              '${orderModel.customer?.name}',
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
                    fontSize: 12.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  formatDate(context, orderModel.createdAt),
                  style: const TextStyle(
                    fontSize: 13.0,
                    color: Colors.black,
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
                    fontSize: 12.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'مش راجع',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            if (orderModel.status == 'Approved')
              const Divider(
                height: 15,
                color: MyColors.mainColor,
                thickness: 0.2,
              ),
            if (orderModel.status == 'Approved')
              BlocBuilder<OrdersCubit, OrdersState>(
                builder: (context, state) {
                  return Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: OrdersCubit.get(context).isLoadingActionreceive && state is OrdersActionLoading && state.id == orderModel.id
                        ? CustomButtonLoading(
                            color: MyColors.green,
                            textColor: Colors.white,
                            height: 33,
                            width: 100,
                            borderRadius: BorderRadius.circular(9),
                          )
                        : CustomButton(
                            text: orderModel.shippingStatus == null
                                ? 'استلم الطلبية'
                                : orderModel.shippingStatus == OrderShoppingStatus.received
                                    ? 'معالجة الطلبية'
                                    : orderModel.shippingStatus == OrderShoppingStatus.processing
                                        ? 'جاري التوصيل'
                                        : 'تم التوصيل',
                            onPressed: () async {
                              if (orderModel.shippingStatus == null) {
                                await OrdersCubit.get(context).updateOrder(
                                  context: context,
                                  orderModel: orderModel,
                                  status: OrderShoppingStatus.received,
                                );
                              } else if (orderModel.shippingStatus == OrderShoppingStatus.received) {
                                await OrdersCubit.get(context).updateOrder(
                                  context: context,
                                  orderModel: orderModel,
                                  status: OrderShoppingStatus.processing,
                                );
                              } else if (orderModel.shippingStatus == OrderShoppingStatus.processing) {
                                await OrdersCubit.get(context).updateOrder(
                                  context: context,
                                  orderModel: orderModel,
                                  status: OrderShoppingStatus.delivery,
                                );
                              } else if (orderModel.shippingStatus == OrderShoppingStatus.delivery) {
                                selectImage(context).then((value) async {
                                  if (value != null) {
                                    await OrdersCubit.get(context).updateOrder(
                                      context: context,
                                      orderModel: orderModel,
                                      status: OrderShoppingStatus.delivered,
                                      file: value,
                                    );
                                  }
                                });
                              }
                            },
                            color: MyColors.green,
                            textColor: Colors.white,
                            height: 33,
                            width: 100,
                            borderRadius: BorderRadius.circular(9),
                          ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
