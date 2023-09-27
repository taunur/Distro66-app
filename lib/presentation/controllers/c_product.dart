import 'package:distro66_app/data/models/product_model.dart';
import 'package:distro66_app/data/sources/source_product.dart';
import 'package:get/get.dart';

class CProduct extends GetxController {
  final _loading = false.obs;
  bool get loading => _loading.value;

  final _category = "all".obs;
  String get category => _category.value;
  set category(String n) {
    _category.value = n;
    update();
  }

  List<String> get categories => [
        "all",
        "men's clothing",
        "jewelery",
        "electronics",
        "women's clothing",
      ];

  final _listProduct = <ProductModel>[].obs;
  List<ProductModel> get listProduct => _listProduct;

  void getlistProduct() async {
    _loading.value = true;
    update();
    _listProduct.value = await ProductSource.getProducts();
    update();

    Future.delayed(const Duration(milliseconds: 900), () {
      _loading.value = false;
      update();
    });
  }

  void searchProduct(query) async {
    _loading.value = true;
    update();
    _listProduct.value = await ProductSource.searchProduct(query);
    update();

    Future.delayed(const Duration(milliseconds: 900), () {
      _loading.value = false;
      update();
    });
  }

  @override
  void onInit() {
    getlistProduct();
    super.onInit();
  }
}
