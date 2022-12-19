import 'package:application/core/utils.dart';
import 'package:application/models/lunch_model.dart';
import 'package:application/models/purchase_model.dart';
import 'package:application/store/app_store/app_store.dart';
import 'package:flutter/material.dart';

class LunchCard extends StatelessWidget {
  final Lunch lunch;
  final AppStore appStore;
  const LunchCard(this.lunch, this.appStore, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: SizedBox(
        width: getScreenWidth(context, percentage: cardWidth),
        height: getScreenHeight(context, percentage: 0.21),
        child: Row(
          children: [
            paddingHorizontal(3),
            Container(
              width: 110,
              height: 110,
              decoration: const BoxDecoration(
                boxShadow: boxShadows,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: Image.network(lunch.url),
              ),
            ),
            paddingHorizontal(3),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  paddingVertical(2.5),
                  Row(
                    children: [
                      Text(lunch.name),
                      paddingHorizontal(2),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          color: getColor(ColorPalette.black),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 3.0, horizontal: 5.0),
                          child: Text(
                            currencyFormat.format(lunch.price),
                            style: TextStyle(
                              color: getColor(ColorPalette.green),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  paddingVertical(1),
                  Text(
                    lunch.description,
                    softWrap: true,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  paddingVertical(1),
                  ElevatedButton(
                    onPressed: () {
                      appStore.api.orderLunch(lunch);
                      var reversedList = appStore.api.user!.purchases!.reversed
                          .toList()
                        ..add(Purchase(
                            lunch.description,
                            "lunch",
                            lunch.price,
                            lunch.price,
                            getPurchaseHistorieDate(DateTime.now())));
                      appStore.api.user!.purchases =
                          reversedList.reversed.toList();

                      appStore.api.user!.balance =
                          appStore.api.user!.balance! - lunch.price;
                      appStore.reloadView();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        getColor(ColorPalette.green),
                      ),
                    ),
                    child: Text(
                      "Bestellen",
                      style: TextStyle(
                        color: getColor(ColorPalette.black),
                      ),
                    ),
                  ),
                  paddingVertical(2.5),
                ],
              ),
            ),
            paddingHorizontal(2),
          ],
        ),
      ),
    );
  }
}
