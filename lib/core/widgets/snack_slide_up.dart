import 'package:application/core/utils.dart';
import 'package:application/core/widgets/snack_card.dart';
import 'package:application/models/snack_model.dart';
import 'package:flutter/material.dart';

class SnackSlideUp extends StatelessWidget {
  final controller;
  const SnackSlideUp(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    var snacks = <Widget>[
      SnackCard(
        Snack(
            "http://192.168.178.103:90/api/files/xpyen9w9jq3zax7/93hqzfwj7q8k231/happy_hippo_pAnr1k1SXu.png",
            "HappyHippo",
            0.6,
            10),
      ),
      paddingHorizontal(2),
      SnackCard(
        Snack(
            "http://192.168.178.103:90/api/files/xpyen9w9jq3zax7/93hqzfwj7q8k231/happy_hippo_pAnr1k1SXu.png",
            "Belegtes Brötchen",
            2.5,
            10),
      ),
      paddingHorizontal(2),
      SnackCard(
        Snack(
            "http://192.168.178.103:90/api/files/xpyen9w9jq3zax7/93hqzfwj7q8k231/happy_hippo_pAnr1k1SXu.png",
            "Belegtes Brötchen",
            2.5,
            10),
      ),
      paddingHorizontal(2),
      SnackCard(
        Snack(
            "http://192.168.178.103:90/api/files/xpyen9w9jq3zax7/93hqzfwj7q8k231/happy_hippo_pAnr1k1SXu.png",
            "Belegtes Brötchen",
            2.5,
            10),
      ),
      paddingHorizontal(2),
      SnackCard(
        Snack(
            "http://192.168.178.103:90/api/files/xpyen9w9jq3zax7/93hqzfwj7q8k231/happy_hippo_pAnr1k1SXu.png",
            "Belegtes Brötchen",
            2.5,
            10),
      ),
      paddingHorizontal(2),
      SnackCard(
        Snack(
            "http://192.168.178.103:90/api/files/xpyen9w9jq3zax7/93hqzfwj7q8k231/happy_hippo_pAnr1k1SXu.png",
            "Belegtes Brötchen",
            2.5,
            10),
      ),
      paddingHorizontal(2),
      SnackCard(
        Snack(
            "http://192.168.178.103:90/api/files/xpyen9w9jq3zax7/93hqzfwj7q8k231/happy_hippo_pAnr1k1SXu.png",
            "Belegtes Brötchen",
            2.5,
            10),
      ),
      paddingHorizontal(2),
      SnackCard(
        Snack(
            "http://192.168.178.103:90/api/files/xpyen9w9jq3zax7/93hqzfwj7q8k231/happy_hippo_pAnr1k1SXu.png",
            "Belegtes Brötchen",
            2.5,
            10),
      ),
      paddingHorizontal(2),
      SnackCard(
        Snack(
            "http://192.168.178.103:90/api/files/xpyen9w9jq3zax7/93hqzfwj7q8k231/happy_hippo_pAnr1k1SXu.png",
            "Belegtes Brötchen",
            2.5,
            10),
      ),
      paddingHorizontal(2),
      SnackCard(
        Snack(
            "http://192.168.178.103:90/api/files/xpyen9w9jq3zax7/93hqzfwj7q8k231/happy_hippo_pAnr1k1SXu.png",
            "Belegtes Brötchen",
            2.5,
            10),
      ),
      paddingHorizontal(2),
      SnackCard(
        Snack(
            "http://192.168.178.103:90/api/files/xpyen9w9jq3zax7/93hqzfwj7q8k231/happy_hippo_pAnr1k1SXu.png",
            "Belegtes Brötchen",
            2.5,
            10),
      ),
      paddingHorizontal(2),
      SnackCard(
        Snack(
            "http://192.168.178.103:90/api/files/xpyen9w9jq3zax7/93hqzfwj7q8k231/happy_hippo_pAnr1k1SXu.png",
            "Belegtes Brötchen",
            2.5,
            10),
      ),
      paddingHorizontal(2),
      SnackCard(
        Snack(
            "http://192.168.178.103:90/api/files/xpyen9w9jq3zax7/93hqzfwj7q8k231/happy_hippo_pAnr1k1SXu.png",
            "Belegtes Brötchen",
            2.5,
            10),
      ),
      paddingHorizontal(2),
      SnackCard(
        Snack(
            "http://192.168.178.103:90/api/files/xpyen9w9jq3zax7/93hqzfwj7q8k231/happy_hippo_pAnr1k1SXu.png",
            "Belegtes Brötchen",
            2.5,
            10),
      ),
      paddingHorizontal(2),
      SnackCard(
        Snack(
            "http://192.168.178.103:90/api/files/xpyen9w9jq3zax7/93hqzfwj7q8k231/happy_hippo_pAnr1k1SXu.png",
            "Belegtes Brötchen",
            2.5,
            10),
      ),
      paddingHorizontal(2),
      SnackCard(
        Snack(
            "http://192.168.178.103:90/api/files/xpyen9w9jq3zax7/93hqzfwj7q8k231/happy_hippo_pAnr1k1SXu.png",
            "Belegtes Brötchen",
            2.5,
            10),
      ),
      paddingHorizontal(2),
      SnackCard(
        Snack(
            "http://192.168.178.103:90/api/files/xpyen9w9jq3zax7/93hqzfwj7q8k231/happy_hippo_pAnr1k1SXu.png",
            "Belegtes Brötchen",
            2.5,
            10),
      ),
      paddingHorizontal(2),
      SnackCard(
        Snack(
            "http://192.168.178.103:90/api/files/xpyen9w9jq3zax7/93hqzfwj7q8k231/happy_hippo_pAnr1k1SXu.png",
            "Belegtes Brötchen",
            2.5,
            10),
      ),
      paddingHorizontal(2),
      SnackCard(
        Snack(
            "http://192.168.178.103:90/api/files/xpyen9w9jq3zax7/93hqzfwj7q8k231/happy_hippo_pAnr1k1SXu.png",
            "Belegtes Brötchen",
            2.5,
            10),
      ),
    ];
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
            height: getScreenHeight(context, percentage: 0.1),
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
              child: Text(
                "Snacks",
                style: TextStyle(
                  color: getColor(ColorPalette.white),
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
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
                itemCount: snacks.length,
                itemBuilder: (context, index) {
                  return snacks[index];
                },
              ),
            ),
          ),
          paddingHorizontal(4),
        ],
      ),
    );
  }
}
