import 'package:d_view/d_view.dart';
import 'package:distro66_app/config/app_color.dart';
import 'package:distro66_app/data/models/product_model.dart';
import 'package:flutter/material.dart';

import 'widgets/favorite_button.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.product});

  final ProductModel product;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: OrientationBuilder(
                  builder: (context, orientation) {
                    double imageHeight;

                    if (orientation == Orientation.portrait) {
                      // Portrait mode: Set the image height to one-third of the screen height
                      imageHeight = MediaQuery.of(context).size.height / 3;
                    } else {
                      // Landscape mode: Set a smaller image height
                      imageHeight = double.infinity;
                    }

                    return Image.network(
                      widget.product.image!,
                      width: double.infinity,
                      height: imageHeight,
                    );
                  },
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColor.primary,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      const FavoriteButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin:
                const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
            child: Text(
              widget.product.title!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          detailProduct("Rating", Icons.star, "${widget.product.rating!.rate}"),
          detailProduct(
              "Vote", Icons.thumb_up_alt, "${widget.product.rating!.count}"),
          DView.spaceWidth(),
          Container(
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Price",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  '\$ ${widget.product.price.toString()}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: const Text(
              "Description",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Text(
              widget.product.description!,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Row(
              children: [
                const Text(
                  "Category : ",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  widget.product.category!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Quantity controls
          Container(
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Quantity: ",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        if (quantity > 0) {
                          // Decrease quantity if greater than 0
                          setState(() {
                            quantity--;
                          });
                        }
                      },
                    ),
                    Text(
                      quantity.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        if (quantity < 100) {
                          // Increase quantity if less than 100
                          setState(() {
                            quantity++;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Add to Cart button
          Container(
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primary,
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Add to Cart",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container detailProduct(String judul, IconData icon, String iconText) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            judul,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          Row(
            children: [
              Icon(
                icon,
                color: icon == Icons.star
                    ? Colors.amber
                    : icon == Icons.thumb_up_alt
                        ? Colors.red
                        : Colors.white,
              ),
              DView.spaceWidth(4),
              Text(
                iconText,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
