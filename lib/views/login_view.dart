import 'package:application/core/utils.dart';
import 'package:application/core/widgets.dart';
import 'package:application/main.dart';
import 'package:application/models/user_model.dart';
import 'package:application/store/app_store/app_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lottie/lottie.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginView());
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class LoginData {
  String? username;
  String? password;
  String? url;
}

class _LoginViewState extends ConsumerState<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _data = LoginData();
  Widget _buttonWidget = const Center(
    child: Icon(
      Icons.arrow_forward_ios,
      color: Colors.black,
    ),
  );

  @override
  void initState() {
    super.initState();

    _data.url = ref.read(appStore).servers[0].api;
  }

  @override
  Widget build(BuildContext context) {
    final _appStore = ref.read(appStore);
    return Scaffold(
      backgroundColor: const Color(0xFFD8FFF0),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 50.0),
          ),
          const Center(
            child: Text(
              'Mampf',
              style: TextStyle(
                  fontFamily: 'Caveat',
                  fontSize: 48.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w800),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 50.0),
          ),
          Expanded(
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF161825),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                width: getScreenWidth(context, percentage: 0.82),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 25.0),
                    ),
                    DropdownSearch(
                      list: _appStore.servers,
                      width: getScreenWidth(context, percentage: 0.625),
                      onChange: (newIndex) {
                        _data.url = _appStore.servers[newIndex].api;
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 150.0),
                    ),
                    const Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 40.0,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 25.0),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              getScreenWidth(context, percentage: 0.195) / 2),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Benutzername',
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF43FFBB)),
                                ),
                              ),
                              cursorColor: const Color(0xFF43FFBB),
                              style: const TextStyle(color: Colors.white),
                              validator: (value) {
                                if (value == null) {
                                  return 'Du musst einen Benutzernamen angeben!';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _data.username = value!;
                              },
                            ),
                            const Padding(padding: EdgeInsets.only(top: 10.0)),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Passwort',
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF43FFBB)),
                                ),
                              ),
                              cursorColor: const Color(0xFF43FFBB),
                              style: const TextStyle(color: Colors.white),
                              validator: (value) {
                                if (value == null) {
                                  return 'Du musst ein Passwort angeben!';
                                }
                                return null;
                              },
                              obscureText: true,
                              onSaved: (value) {
                                _data.password = value!;
                              },
                            ),
                            const Padding(padding: EdgeInsets.only(top: 50.0)),
                            GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFF43FFBB),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                width: 50.0,
                                height: 50.0,
                                child: _buttonWidget,
                              ),
                              onTap: () async {
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }
                                _formKey.currentState!.save();

                                setState(() {
                                  _buttonWidget = LottieBuilder.network(
                                    "https://lottie.host/dddb2625-ab03-40b7-b53d-7da798d7d7a6/p1L2EOAd06.json",
                                    repeat: true,
                                    animate: true,
                                  );
                                });

                                await _appStore.secureStorage
                                    .setURL(_data.url!);
                                await _appStore.secureStorage
                                    .setUsername(_data.username!);
                                await _appStore.secureStorage
                                    .setPassword(_data.password!);

                                var ret = await _appStore.api
                                    .connectToMampfServer(_data.url!,
                                        _data.username!, _data.password!);

                                if (ret.responseCode == 0) {
                                  _appStore.changeAuthenticationState(
                                      AuthState.authenticated);
                                }

                                print(ret.responseMessage);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 50.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 80.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Impressum',
                style: TextStyle(
                  color: Color(0xFF161825),
                  fontSize: 14.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10.0),
              ),
              Text(
                'Datenschutz',
                style: TextStyle(
                  color: Color(0xFF161825),
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 10.0),
          ),
        ],
      ),
    );
  }
}
