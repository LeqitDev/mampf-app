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
import 'package:flutter_mobx/flutter_mobx.dart';
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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Observer(
              builder: (context) {
                if (_appStore.reload == true) {
                  return Container();
                } else {
                  return Center(
                    child: SizedBox(
                      width: getScreenWidth(context, percentage: cardWidth),
                      child: Column(
                        children: [
                          paddingVertical(2),
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
                                        color:
                                            getColor(ColorPalette.lightGreen),
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
                          if (_appStore.api.user!.lunchOrders.isNotEmpty)
                            for (var widget in getLunchOrders(_appStore))
                              widget,
                          paddingVertical(5),
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
                                  paddingVertical(5.0),
                                  Text(
                                    "Dein Guthaben",
                                    style: TextStyle(
                                      color: getColor(ColorPalette.lightGreen),
                                      fontSize: 32.0,
                                    ),
                                  ),
                                  Text(
                                    currencyFormat
                                        .format(_appStore.api.user!.balance),
                                    style: TextStyle(
                                      color: getColor(ColorPalette.white),
                                      fontSize: 64.0,
                                    ),
                                  ),
                                  paddingVertical(7.0),
                                ],
                              ),
                            ),
                          ),
                          paddingVertical(5),
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
                              }, "Mittagessen bestellen",
                                  Icons.restaurant_menu),
                              FastAction(() {
                                setState(() {
                                  _slideUpWidget = (sc) {
                                    return SnackSlideUp(sc);
                                  };
                                  panelController.open();
                                });
                              }, "Snack kaufen", Icons.cookie),
                              FastAction(() {}, "Guthaben aufladen",
                                  Icons.attach_money),
                            ],
                          ),
                          paddingVertical(5),
                          PurchaseHistory(
                            purchases: _appStore.api.user!.purchases!,
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
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

  getLunchOrders(AppStore _appStore) {
    return <Widget>[
      paddingVertical(5),
      SizedBox(
        width: double.infinity,
        child: Card(
          elevation: 5,
          color: getColor(ColorPalette.lightGreen),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            child: Column(
              children: [
                for (var lunchOrder in _appStore.api.user!.lunchOrders)
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: getColor(ColorPalette.black),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: Icon(
                            icons[categorieToIndex("lunch")],
                            color: getColor(ColorPalette.lightGreen),
                            size: 25,
                          ),
                        ),
                        paddingHorizontal(2),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                errorCodeFormat.format(lunchOrder.orderId),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                lunchOrder.description,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        paddingHorizontal(2),
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              getColor(ColorPalette.green),
                            ),
                          ),
                          child: Text(
                            "Anzeigen",
                            style:
                                TextStyle(color: getColor(ColorPalette.black)),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    ];
  }
}
