import 'package:rider/models/product/product_model.dart';

class SelectedProductsModel {
  static List<SelectedProductsModel> selectedProducts = [];

  late ProductModel productModel;
  late int qty;

  SelectedProductsModel({required this.productModel, required this.qty});
}
