import 'package:application/core/utils.dart';
import 'package:application/models/purchase_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PurchaseHistory extends StatelessWidget {
  final List<Purchase> purchases;
  const PurchaseHistory({super.key, required this.purchases});

  @override
  Widget build(BuildContext context) {
    final List<IconData> icons = [
      Icons.restaurant_menu,
      Icons.cookie,
      Icons.attach_money
    ];

    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 5,
        color: getColor(ColorPalette.lightGreen),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 50.0),
                child: Column(
                  children: [
                    for (var purchase in purchases.getRange(0, 3))
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: getColor(ColorPalette.black),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                child: Icon(
                                  icons[categorieToIndex(purchase.categorie)],
                                  color: getColor(ColorPalette.lightGreen),
                                  size: 25,
                                ),
                              ),
                              paddingHorizontal(1),
                              Container(
                                height: 25.0,
                                width: 2.0,
                                color: getColor(ColorPalette.black),
                              ),
                              paddingHorizontal(1),
                            ],
                          ),
                          paddingVertical(2),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                purchase.date,
                                style: const TextStyle(fontSize: 12),
                              ),
                              Text(
                                purchase.name,
                                style: const TextStyle(fontSize: 14),
                              ),
                              Text(
                                purchase.categorie == "credits"
                                    ? "+ ${currencyFormat.format(purchase.price)}"
                                    : "- ${currencyFormat.format(purchase.price)}",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: purchase.categorie == "credits"
                                        ? Colors.green
                                        : Colors.red),
                              ),
                            ],
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              paddingHorizontal(2),
              GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    color: getColor(ColorPalette.black),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(11.0),
                      bottomRight: Radius.circular(11.0),
                    ),
                    border: Border.all(color: Colors.black, width: 3.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Gesamten Verlauf anzeigen",
                          style: TextStyle(
                            color: getColor(ColorPalette.white),
                            fontSize: 16,
                          ),
                        ),
                        Icon(
                          Icons.arrow_right_alt,
                          color: getColor(ColorPalette.green),
                          size: 25,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
