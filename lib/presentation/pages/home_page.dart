import 'package:d_view/d_view.dart';
import 'package:distro66_app/config/app_color.dart';
import 'package:distro66_app/config/session.dart';
import 'package:distro66_app/data/models/product_model.dart';
import 'package:distro66_app/presentation/controllers/c_product.dart';
import 'package:distro66_app/presentation/controllers/c_user.dart';
import 'package:distro66_app/presentation/pages/auth/login_page.dart';
import 'package:distro66_app/presentation/pages/cart_page.dart';
import 'package:distro66_app/presentation/pages/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final cUser = Get.put(CUser());
  final cProduct = Get.put(CProduct());
  final searchingController = TextEditingController();

  @override
  void dispose() {
    searchingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: appBar(context, cUser),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: [
            searchField(searchingController, cProduct),
            DView.spaceHeight(),
            categories(cProduct),
            DView.spaceHeight(),
            product(screenWidth),
          ],
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context, CUser cUser) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text("Hi, Selamat Datang"),
      actions: [
        IconButton(
          onPressed: () {
            Get.to(() => const CartPage());
          },
          icon: const Icon(Icons.shopping_cart_outlined),
        ),
        IconButton(
            onPressed: () {
              Alert(
                context: context,
                type: AlertType.warning,
                title: "Distro66",
                desc: "Do you want logout ?",
                buttons: [
                  DialogButton(
                    onPressed: () => Navigator.pop(context),
                    width: 120,
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  DialogButton(
                    color: Colors.red,
                    onPressed: () {
                      Session.clearToken();
                      Get.offAll(() => const LoginPage());
                    },
                    width: 120,
                    child: const Text(
                      "Yes",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                ],
              ).show();
            },
            icon: const Icon(Icons.logout)),
      ],
    );
  }

  GetBuilder<CProduct> categories(CProduct cProduct) {
    return GetBuilder<CProduct>(builder: (_) {
      return SizedBox(
        height: 45,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: _.categories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            String category = _.categories[index];
            return Padding(
              padding: EdgeInsets.fromLTRB(
                index == 0 ? 0 : 8,
                0,
                index == cProduct.categories.length - 1 ? 0 : 8,
                0,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Material(
                  elevation: 1,
                  color:
                      category == _.category ? AppColor.primary : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      _.category = category;
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        category,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: category == _.category
                                  ? Colors.white
                                  : Colors.black,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }

  SizedBox searchField(TextEditingController controller, CProduct cProduct) {
    return SizedBox(
      height: 45,
      child: Stack(
        children: [
          Container(
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                  color: Colors.black.withOpacity(0.6),
                  spreadRadius: -5,
                )
              ],
            ),
            child: TextField(
              onChanged: (value) {
                cProduct.searchProduct(
                  controller.text,
                );
              },
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Search by name',
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Material(
              color: AppColor.secondary,
              borderRadius: BorderRadius.circular(45),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(45),
                child: const SizedBox(
                  width: 45,
                  height: 45,
                  child: Center(
                      child: Icon(
                    Icons.search,
                    color: Colors.white,
                  )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  GetBuilder<CProduct> product(double screenWidth) {
    return GetBuilder<CProduct>(
      builder: (_) {
        List<ProductModel> list;
        if (_.loading) return Center(child: DView.loadingCircle());
        if (_.category == 'all') {
          list = _.listProduct;
        } else {
          list = _.listProduct
              .where((element) => element.category == _.category)
              .toList();
        }
        if (_.listProduct.isEmpty) {
          return const Center(
            child: Text("Item Not Found"),
          );
        }

        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: list.length,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: (screenWidth - 30 - 15) / (2 * 280),
          ),
          itemBuilder: (context, index) {
            ProductModel product = list[index];
            return GestureDetector(
              onTap: () {
                Get.to(
                  () => DetailPage(product: product),
                );
              },
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 140,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(product.image ??
                                    "https://cdn.pixabay.com/photo/2018/03/17/20/51/white-buildings-3235135__340.jpg"),
                                fit: BoxFit.contain),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        product.title ?? "No Title",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '\$ ${product.price.toString()}',
                        style: const TextStyle(
                          color: AppColor.primary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
