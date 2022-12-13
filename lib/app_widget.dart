import 'package:application/main.dart';
import 'package:application/store/app_store/app_store.dart';
import 'package:application/views/login_view.dart';
import 'package:application/views/main_view.dart';
import 'package:application/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  void initState() {
    final _appStore = ref.read(appStore)
      ..setAppVersion(const String.fromEnvironment("APP_VERSION"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _appStore = ref.read(appStore);

    return MaterialApp(
      title: "Mampf",
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        final dispose =
            _appStore.addReaction((_) => _appStore.state, (newState) {
          switch (newState) {
            case AuthState.unknown:
              _navigator.pushAndRemoveUntil(
                  SplashView.route(), (route) => false);
              break;
            case AuthState.unauthenticated:
              _navigator.pushAndRemoveUntil(
                  LoginView.route(), (route) => false);
              break;
            case AuthState.authenticated:
              _navigator.pushAndRemoveUntil(MainView.route(), (route) => false);
              break;
          }
        });
        return child!;
      },
      onGenerateRoute: (_) => SplashView.route(),
      routes: {},
      theme: ThemeData(
        fontFamily: 'Alexandria',
      ),
    );
  }
}
