import 'package:application/core/utils.dart';
import 'package:application/models/lunch_model.dart';
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
        width: getScreenWidth(context, percentage: 0.82),
        height: getScreenHeight(context, percentage: 0.15),
        child: Row(
          children: [
            paddingVertical(3),
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
            paddingVertical(3),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  paddingHorizontal(2.5),
                  Row(
                    children: [
                      Text(lunch.name),
                      paddingVertical(2),
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
                  paddingHorizontal(1),
                  Text(
                    lunch.description,
                    softWrap: true,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  paddingHorizontal(1),
                  ElevatedButton(
                    onPressed: () {
                      appStore.api.orderLunch(lunch);
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
                  paddingHorizontal(2.5),
                ],
              ),
            ),
            paddingVertical(2),
          ],
        ),
      ),
    );
  }
}
