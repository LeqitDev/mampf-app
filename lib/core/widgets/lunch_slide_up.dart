import 'package:application/core/utils.dart';
import 'package:application/core/widgets.dart';
import 'package:application/models/lunch_model.dart';
import 'package:application/store/app_store/app_store.dart';
import 'package:flutter/material.dart';

class LunchSlideUp extends StatelessWidget {
  List<Lunch> lunches;
  ScrollController controller;
  AppStore appStore;

  LunchSlideUp(this.lunches, this.controller, this.appStore, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: getColor(ColorPalette.lightGreen),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            height: getScreenHeight(context, percentage: 0.13),
            decoration: BoxDecoration(
              color: getColor(ColorPalette.dark),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(11.0),
                topRight: Radius.circular(11.0),
              ),
              boxShadow: boxShadows,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mittagessen",
                    style: TextStyle(
                      color: getColor(ColorPalette.white),
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  paddingHorizontal(1),
                  Text(
                    "Mittwoch, 13.12.",
                    style: TextStyle(
                      color: getColor(ColorPalette.lightGreen),
                      fontSize: 25,
                      fontFamily: "Caveat",
                    ),
                  ),
                ],
              ),
            ),
          ),
          paddingHorizontal(4),
          GestureDetector(
            onTap: () {},
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              color: getColor(ColorPalette.green),
              child: SizedBox(
                width: getScreenWidth(context, percentage: 0.82),
                height: getScreenHeight(context, percentage: 0.04),
                child: Row(
                  children: [
                    paddingVertical(2),
                    Icon(
                      Icons.calendar_month,
                      color: getColor(ColorPalette.black),
                      size: 25,
                    ),
                    paddingVertical(2),
                    Text(
                      "Tag ändern",
                      style: TextStyle(
                          color: getColor(ColorPalette.black),
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ),
          paddingHorizontal(8),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getScreenWidth(context, percentage: 0.09),
              ),
              child: ListView.builder(
                controller: controller,
                shrinkWrap: true,
                itemCount: lunches.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      LunchCard(lunches[index], appStore),
                      paddingHorizontal(2)
                    ],
                  );
                },
              ),
            ),
          ),
          paddingHorizontal(2),
        ],
      ),
    );
  }
}
