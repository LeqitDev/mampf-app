import 'package:application/core/utils.dart';
import 'package:application/models/snack_model.dart';
import 'package:flutter/material.dart';

class SnackCard extends StatelessWidget {
  final Snack snack;
  const SnackCard(this.snack, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: SizedBox(
        width: getScreenWidth(context, percentage: 0.82),
        height: getScreenHeight(context, percentage: 0.1),
        child: Row(
          children: [
            paddingVertical(3),
            SizedBox(
              width: 60,
              height: 60,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: Image.network(snack.url),
              ),
            ),
            paddingVertical(3),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  paddingHorizontal(2),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          snack.name,
                          softWrap: true,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          color: getColor(ColorPalette.black),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 3.0, horizontal: 5.0),
                          child: Text(
                            currencyFormat.format(snack.price),
                            style: TextStyle(
                              color: getColor(ColorPalette.green),
                            ),
                          ),
                        ),
                      ),
                      paddingVertical(3),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
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
                  paddingHorizontal(2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
