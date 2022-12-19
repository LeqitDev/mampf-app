import 'package:application/core/utils.dart';
import 'package:application/main.dart';
import 'package:application/store/app_store/app_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SplashView());
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  final size = Tween<double>(begin: 0.0, end: 500.0);
  var _apiConnected = false;
  var _serverConnected = false;
  var _blendColor = getColor(ColorPalette.lightGreen);

  getServers() async {
    final _appStore = ref.read(appStore);
    // await _appStore.secureStorage.eraseAll();

    // Loading State 0
    _appStore.updateSplashLoading(1);

    var url = await _appStore.secureStorage.getURL();
    var username = await _appStore.secureStorage.getUsername();
    var password = await _appStore.secureStorage.getPassword();

    // Loading State 1
    _appStore.updateSplashLoading(2);

    if (url != null && username != null && password != null) {
      await _appStore.api.init().then((value) async {
        if (value.responseCode == 0) {
          await _appStore.fetchServers();

          // Loading State 2
          _appStore.updateSplashLoading(3);

          await _appStore.api
              .connectToMampfServer(url, username, password)
              .then((ret) async {
            if (ret.responseCode == 0) {
              _serverConnected = true;
              _blendColor = getColor(ColorPalette.dark);

              // Loading State 3 (Full)
              _appStore.updateSplashLoading(4);

              Future.delayed(
                const Duration(milliseconds: 500),
                () {
                  animationController.forward();
                  Future.delayed(
                      const Duration(milliseconds: 500),
                      () => _appStore
                          .changeAuthenticationState(AuthState.authenticated));
                },
              );
              // _appStore.changeAuthenticationState(AuthState.authenticated);
            } else {
              //TODO: Error handling
              print("${ret.responseMessage} (${ret.responseCode})");
            }
          }).onError((error, stackTrace) {
            //TODO: Error handling
            print("Error");
          });
        } else {
          //TODO: Error handling
          print(
              "${value.responseMessage} (${value.responseCode}) | Couldnt load the server lists");
        }
      });
    } else {
      await _appStore.api.init().then((value) {
        if (value.responseCode == 0) {
          _apiConnected = true;
        } else {
          //TODO: Error handling
          print("${value.responseMessage} (${value.responseCode})");
        }
      });

      if (_apiConnected) {
        await _appStore.fetchServers();

        // Loading State 2 (Full)
        _appStore.updateSplashLoading(4);

        if (!_serverConnected) {
          Future.delayed(
            const Duration(milliseconds: 500),
            () {
              animationController.forward();
              Future.delayed(
                  const Duration(milliseconds: 500),
                  () => _appStore
                      .changeAuthenticationState(AuthState.unauthenticated));
            },
          );
        } else {
          //TODO: Error handling
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350));
    animation = Tween<double>(begin: 0.0, end: 500.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      });

    getServers();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _appStore = ref.read(appStore);

    return Scaffold(
      backgroundColor: getColor(ColorPalette.black),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Mampf',
                  style: TextStyle(
                    fontFamily: 'Caveat',
                    color: Color(0xFF43FFBB),
                    fontWeight: FontWeight.w700,
                    fontSize: 64.0,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Observer(
                  builder: (context) {
                    return SizedBox(
                      width: getScreenWidth(context, percentage: 0.35),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: LinearProgressIndicator(
                          value: _appStore.splashLoading,
                          backgroundColor: getColor(ColorPalette.lightGreen),
                          color: getColor(ColorPalette.green),
                          minHeight: 8.0,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          CustomPaint(
            size: const Size(double.infinity, double.infinity),
            painter: FadeCirclePainter(animationController.view,
                getScreenHeight(context, percentage: 0.6), _blendColor),
          ),
          /* Container(
            decoration: const BoxDecoration(
              color: Color(0xFFD8FFF0),
            ),
            width: animation.value,
            height: animation.value,
          ), */
        ],
      ),
    );
  }
}
