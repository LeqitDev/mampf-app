import 'package:application/app_widget.dart';
import 'package:application/store/app_store/app_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appStore = Provider((_) => AppStore());

void main() {
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}
