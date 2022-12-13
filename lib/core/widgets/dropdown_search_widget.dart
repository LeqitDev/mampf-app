import 'dart:collection';

import 'package:application/core/utils.dart';
import 'package:application/models/server_model.dart';
import 'package:flutter/material.dart';

class DropdownSearch extends StatefulWidget {
  final List<Server> list;
  final double? width;
  final double? height;
  final Function(int) onChange;

  const DropdownSearch(
      {super.key,
      required this.list,
      this.width,
      this.height,
      required this.onChange});

  @override
  State<DropdownSearch> createState() => _DropdownSearchState();
}

class _DropdownSearchState extends State<DropdownSearch>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  bool _clicked = false;
  late Animation<double> _heightAnimation;
  late final AnimationController _controller;
  double _height = 0;

  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));

    _heightAnimation = Tween<double>(begin: 0, end: 110)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: normalWidget(roundedBottom: _clicked),
      onTap: () {
        _clicked = !_clicked;
        setState(() {
          if (_clicked) {
            _overlayEntry = _createOverlayEntry();
            Overlay.of(context)?.insert(_overlayEntry!);
            _height = 140;
          } else {
            _height = 0;
            _overlayEntry?.remove();
            Future.delayed(const Duration(milliseconds: 200), () {});
          }
        });
      },
    );
  }

  normalWidget({bool? roundedBottom}) {
    return Container(
      decoration: BoxDecoration(
        color: getColor(ColorPalette.green),
        borderRadius: roundedBottom ?? false
            ? const BorderRadius.only(
                topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0))
            : BorderRadius.circular(25.0),
        boxShadow: boxShadows,
      ),
      width: widget.width ?? 100,
      height: widget.height ?? 50.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.list.elementAt(_currentIndex).name!,
                softWrap: true,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ),
            Icon(
              _clicked ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              size: 40.0,
            ),
          ],
        ),
      ),
    );
  }

  /* downedWidget() {
    return Stack(
      children: [
        normalWidget(roundedBottom: true),
      ],
    );
  } */

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    var editedList = [...widget.list];
    editedList.removeAt(_currentIndex);
    if (editedList.isEmpty) {
      editedList.add(Server("Keine anderen Server vorhanden!", ""));
    }

    return OverlayEntry(
      builder: (context) {
        return Positioned(
          left: offset.dx,
          top: offset.dy + size.height,
          child: Material(
            color: Colors.transparent,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: getColor(ColorPalette.green),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0),
                ),
              ),
              width: size.width,
              height: _height,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Column(
                    children: [
                      Divider(color: getColor(ColorPalette.black)),
                      ListView.separated(
                        separatorBuilder: (context, index) => Divider(
                          color: getColor(ColorPalette.black),
                        ),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: editedList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              editedList[index].name!,
                              softWrap: true,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                              textAlign: TextAlign.center,
                            ),
                            onTap: () => setState(() {
                              _currentIndex =
                                  widget.list.indexOf(editedList[index]);
                              widget.onChange(_currentIndex);
                              _clicked = false;
                              _overlayEntry?.remove();
                            }),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
