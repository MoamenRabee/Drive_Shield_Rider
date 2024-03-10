import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rider/data/constants/api_constants.dart';
import 'package:rider/data/constants/assets.dart';
import 'package:rider/data/constants/constants.dart';
import 'package:rider/functions/functions.dart';
import 'package:rider/helpers/my_navigation.dart';
import 'package:rider/models/order/order_model.dart';
import 'package:rider/models/order_item/order_item_model.dart';
import 'package:rider/persentation/widgets/image_loading.dart';
import 'package:rider/theme/colors.dart';
import 'package:timeline_tile/timeline_tile.dart';

class OrderDetailsScreen extends StatelessWidget {
  OrderDetailsScreen({super.key, required this.orderModel});

  OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 20,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'تفاصيل الطلبية',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          CircleAvatar(
            radius: 20,
            backgroundColor: MyColors.black,
            child: IconButton(
              onPressed: () {
                MyNavigator.back(context);
              },
              icon: SizedBox(
                width: 20,
                height: 20,
                child: Transform.flip(flipX: context.locale.languageCode == 'ar' ? false : true, child: SvgPicture.asset(AssetsSVG.next)),
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _orderDetails(context, orderModel),
              const SizedBox(height: 20),
              _orderProducts(orderModel),
              const SizedBox(height: 20),
              _orderTimeLine(orderModel),
              const SizedBox(height: 20),
              _orderImage(orderModel),
              const SizedBox(height: 20),
              CircleAvatar(
                backgroundColor: Colors.grey[200],
                radius: 30,
                child: SvgPicture.asset(AssetsSVG.camera),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _orderDetails(BuildContext context, OrderModel orderModel) {
  return Container(
    width: 346.0,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: MyColors.gray,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'المرجع',
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
                fontSize: 11.0,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              formatDate(context, orderModel.createdAt),
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
      ],
    ),
  );
}

Widget _orderProducts(OrderModel orderModel) {
  return Container(
    width: 346.0,
    padding: const EdgeInsets.symmetric(
      horizontal: 20,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: MyColors.gray,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 20),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _productCard(context, orderModel.orderItems![index]);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 10);
          },
          itemCount: orderModel.orderItems?.length ?? 0,
        ),
      ],
    ),
  );
}

Container _productCard(BuildContext context, OrderItemModel orderItemModel) {
  return Container(
    width: 377.0,
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
                double.parse(orderItemModel.quantity).toInt().toString(),
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const Text(
          '1',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Widget _orderTimeLine(OrderModel orderModel) {
  List<String> listTitle = [
    'استلم الطلبية',
    'معالجة الطلبية',
    'في الطريق',
    'تم تسليم الطلبية',
  ];

  List<int> activatedTitle = [];

  if (orderModel.shippingStatus != null) {
    activatedTitle.add(0);
  }

  if (orderModel.shippingStatus == OrderShoppingStatus.processing || orderModel.shippingStatus == OrderShoppingStatus.delivery || orderModel.shippingStatus == OrderShoppingStatus.delivered) {
    activatedTitle.add(1);
  }

  if (orderModel.shippingStatus == OrderShoppingStatus.delivery || orderModel.shippingStatus == OrderShoppingStatus.delivered) {
    activatedTitle.add(2);
  }
  if (orderModel.shippingStatus == OrderShoppingStatus.delivered) {
    activatedTitle.add(3);
  }

  return Container(
    width: 346.0,
    padding: const EdgeInsets.symmetric(
      horizontal: 20,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: MyColors.gray,
    ),
    child: Column(
      children: [
        ...List.generate(listTitle.length, (index) {
          return SizedBox(
            height: 50,
            child: TimelineTile(
              alignment: TimelineAlign.start,
              lineXY: 0.0,
              endChild: Container(
                margin: const EdgeInsetsDirectional.only(start: 10),
                constraints: const BoxConstraints(
                  minHeight: 120,
                ),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    listTitle[index],
                    style: const TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              indicatorStyle: IndicatorStyle(
                color: activatedTitle.contains(index) ? MyColors.green.withOpacity(0.2) : Colors.transparent,
                iconStyle: activatedTitle.contains(index) ? IconStyle(iconData: Icons.circle, color: Colors.green, fontSize: 13) : IconStyle(iconData: Icons.circle, color: Colors.grey),
                drawGap: true,
              ),
              afterLineStyle: const LineStyle(
                color: MyColors.green,
                thickness: 1,
              ),
              beforeLineStyle: const LineStyle(
                color: MyColors.green,
                thickness: 1,
              ),
              isFirst: index == 0,
              isLast: index == listTitle.length - 1,
            ),
          );
        }),
      ],
    ),
  );
}

Widget _orderImage(OrderModel orderModel) {
  return Container(
    width: 346.0,
    height: 100,
    padding: const EdgeInsets.symmetric(
      horizontal: 20,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: MyColors.gray,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        orderModel.confirmationImage != null
            ? loadingImage(
                image: ApiConstants.stoarge + orderModel.confirmationImage!,
                borderRadius: BorderRadius.circular(15),
              )
            : const Text(
                'صورة بتسليم الطلبية',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
      ],
    ),
  );
}
