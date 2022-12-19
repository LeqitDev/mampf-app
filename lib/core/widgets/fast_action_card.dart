import 'package:application/core/utils.dart';
import 'package:flutter/material.dart';

class FastActionCard extends StatelessWidget {
  final List<FastAction> actions;
  const FastActionCard({super.key, required this.actions});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 10.0,
        color: getColor(ColorPalette.lightGreen),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var action in actions)
                GestureDetector(
                  onTap: () {
                    action.onTap();
                  },
                  child: SizedBox(
                    width: getScreenWidth(context) / (actions.length * 1.5),
                    child: Column(
                      children: [
                        Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              color: getColor(ColorPalette.green),
                              boxShadow: boxShadows),
                          child: Icon(
                            action.icon,
                            size: 25.0,
                            color: getColor(ColorPalette.black),
                          ),
                        ),
                        paddingVertical(2.0),
                        Text(
                          action.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: getColor(ColorPalette.black),
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class FastAction {
  final Function() onTap;
  final String title;
  final IconData icon;

  FastAction(this.onTap, this.title, this.icon);
}
