import 'package:d_view/d_view.dart';
import 'package:distro66_app/config/app_color.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Shopping Cart",
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Shopping Cart",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              DView.spaceHeight(),
              const Text(
                "No items",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ],
          ),
          DView.spaceHeight(),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "Your order summary",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  Divider(),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Product",
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            "0",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: AppColor.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Price",
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            "\$ 0.00",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: AppColor.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Add to Cart button
          Container(
            margin: const EdgeInsets.only(top: 16, bottom: 16),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primary,
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Checkout",
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
}
