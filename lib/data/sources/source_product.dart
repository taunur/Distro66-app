import 'package:d_method/d_method.dart';
import 'package:dio/dio.dart';
import 'package:distro66_app/config/api.dart';
import 'package:distro66_app/data/models/product_model.dart';

class ProductSource {
  // getProducts
  static Future<List<ProductModel>> getProducts() async {
    try {
      final Response response = await Dio().get(Api.products);

      if (response.statusCode == 200) {
        final List<dynamic> productsData = response.data;

        final List<ProductModel> products = productsData
            .map((productData) => ProductModel.fromJson(productData))
            .toList();

        DMethod.printTitle(
            'getProduct - ${Api.products}', response.data.toString());
        return products;
      } else {
        throw Exception('Failed to fetch products');
      }
    } catch (e) {
      throw Exception('Error Get Product: $e');
    }
  }

  // search
  static Future<List<ProductModel>> searchProduct(String query) async {
    try {
      final Response response = await Dio().get(Api.products);

      if (response.statusCode == 200) {
        final List<dynamic> productsData = response.data;

        final List<ProductModel> products = productsData
            .map((productData) => ProductModel.fromJson(productData))
            .toList();

        DMethod.printTitle(
            'try-products - ${Api.products}', response.data.toString());
        return products.where((judul) {
          final judulName = judul.title!.toLowerCase();
          final searchLower = query.toLowerCase();
          return judulName.contains(searchLower);
        }).toList();
      } else {
        throw Exception('Failed to fetch products');
      }
    } catch (e) {
      throw Exception('Error Get Product: $e');
    }
  }
}
