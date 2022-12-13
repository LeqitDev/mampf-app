import 'dart:ui';

import 'package:application/core/utils.dart';
import 'package:application/core/widgets.dart';
import 'package:application/core/widgets/lunch_slide_up.dart';
import 'package:application/core/widgets/snack_slide_up.dart';
import 'package:application/main.dart';
import 'package:application/models/lunch_model.dart';
import 'package:application/models/purchase_model.dart';
import 'package:application/store/app_store/app_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const MainView());
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  final PanelController panelController = PanelController();
  Function(ScrollController) _slideUpWidget = (sc) {
    return Container();
  };

  @override
  Widget build(BuildContext context) {
    final _appStore = ref.read(appStore);

    return Scaffold(
      backgroundColor: getColor(ColorPalette.dark),
      body: SlidingUpPanel(
        body: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: getScreenWidth(context, percentage: 0.82),
              child: Column(
                children: [
                  paddingHorizontal(2),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: RichText(
                            text: TextSpan(
                              text: "Hallo, ",
                              style: TextStyle(
                                fontFamily: "Caveat",
                                color: getColor(ColorPalette.lightGreen),
                                fontSize: 34.0,
                              ),
                              children: [
                                TextSpan(
                                  text: "Markus",
                                  style: TextStyle(
                                    fontFamily: "Alexandria",
                                    color: getColor(ColorPalette.white),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 28.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          // logout later settings
                          await _appStore.secureStorage.eraseAll();
                          _appStore.changeAuthenticationState(
                              AuthState.unauthenticated);
                        },
                        icon: Icon(
                          Icons.settings,
                          color: getColor(ColorPalette.green),
                          size: 32.0,
                        ),
                      ),
                    ],
                  ),
                  paddingHorizontal(10),
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 5,
                      color: getColor(ColorPalette.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        children: [
                          paddingHorizontal(5.0),
                          Text(
                            "Dein Guthaben",
                            style: TextStyle(
                              color: getColor(ColorPalette.lightGreen),
                              fontSize: 32.0,
                            ),
                          ),
                          Text(
                            currencyFormat.format(_appStore.api.user!.balance),
                            style: TextStyle(
                              color: getColor(ColorPalette.white),
                              fontSize: 64.0,
                            ),
                          ),
                          paddingHorizontal(7.0),
                        ],
                      ),
                    ),
                  ),
                  paddingHorizontal(5),
                  FastActionCard(
                    actions: <FastAction>[
                      FastAction(() {
                        setState(() {
                          _slideUpWidget = (sc) {
                            return LunchSlideUp(
                                _appStore.api.user!.lunches ?? [],
                                sc,
                                _appStore);
                          };
                          panelController.open();
                        });
                      }, "Mittagessen bestellen", Icons.restaurant_menu),
                      FastAction(() {
                        setState(() {
                          _slideUpWidget = (sc) {
                            return SnackSlideUp(sc);
                          };
                          panelController.open();
                        });
                      }, "Snack kaufen", Icons.cookie),
                      FastAction(
                          () {}, "Guthaben aufladen", Icons.attach_money),
                    ],
                  ),
                  paddingHorizontal(5),
                  PurchaseHistory(
                    purchases: <Purchase>[
                      Purchase(
                          "Käsebrötchen", "snack", 1.40, 10.0, "01.01.2023"),
                      Purchase("Guthaben", "credits", 10.0, 10.0, "24.12.2022"),
                      Purchase("Pizza", "snack", 2.20, 10.0, "19.12.2022"),
                      Purchase(
                          "Mittagessen", "lunch", 3.40, 10.0, "18.12.2022"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        panelBuilder: (sc) => _slideUpWidget(sc),
        controller: panelController,
        color: Colors.transparent,
        backdropEnabled: true,
        defaultPanelState: PanelState.CLOSED,
        minHeight: 0.0,
        maxHeight: getScreenHeight(context, percentage: 0.84),
      ),
    );
  }
}
