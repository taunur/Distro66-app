import 'package:d_view/d_view.dart';
import 'package:distro66_app/config/app_asset.dart';
import 'package:distro66_app/config/app_color.dart';
import 'package:distro66_app/data/models/product_model.dart';
import 'package:distro66_app/presentation/pages/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:distro66_app/presentation/controllers/c_product.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cProduct = Get.put(CProduct());

    return SafeArea(
      child: Scaffold(
        appBar: appBar(context),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: [
            DView.spaceHeight(),
            categories(cProduct),
            DView.spaceHeight(),
            product(screenWidth),
          ],
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Image.asset(
            AppAsset.logo,
            width: 24,
          ),
          DView.spaceWidth(4),
          const Text("Distro66"),
        ],
      ),
      actions: [
        IconButton(
            onPressed: () {
              Get.to(() => const LoginPage());
            },
            icon: const Icon(Icons.login)),
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

  GetBuilder<CProduct> product(double screenWidth) {
    return GetBuilder<CProduct>(
      builder: (_) {
        List<ProductModel> list;
        if (_.category == 'all') {
          list = _.listProduct;
        } else {
          list = _.listProduct
              .where((element) => element.category == _.category)
              .toList();
        }

        if (list.isEmpty) {
          return const Center(
            child: Text("Empty"),
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
                  () => const LoginPage(),
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
