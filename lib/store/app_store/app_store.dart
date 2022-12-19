import 'dart:collection';

import 'package:application/models/server_model.dart';
import 'package:application/providers/api.dart';
import 'package:application/providers/secure_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
part 'app_store.g.dart';

class AppStore = _AppStoreBase with _$AppStore;

enum AuthState { unknown, unauthenticated, authenticated }

abstract class _AppStoreBase with Store {
  // General
  String appVersion = "0.0";

  @observable
  bool dev = false;

  @action
  void setAppVersion(String appVersion) {
    if (appVersion.contains("dev")) {
      dev = true;
    }
    this.appVersion = appVersion;
  }

  final SecureStorage _secureStorage = SecureStorage();

  @computed
  SecureStorage get secureStorage => _secureStorage;

  // API
  final API _api = API();

  @computed
  API get api => _api;

  // API Data
  final List<Server> _servers = [];

  @computed
  List<Server> get servers => _servers;

  @observable
  bool serverFetched = false;

  @observable
  bool _reload = false;

  @computed
  bool get reload => _reload;

  @action
  Future fetchServers() async {
    serverFetched = false;
    HashMap<String, String> list = await api.getServers();

    list.forEach((key, value) {
      _servers.add(Server(key, value));
    });
    serverFetched = true;
  }

  // Auth
  @observable
  AuthState state = AuthState.unknown;

  @action
  void changeAuthenticationState(AuthState newState) {
    state = newState;
  }

  // Loading
  @observable
  double splashLoading = 0.0;

  @action
  void updateSplashLoading(int step) {
    switch (step) {
      case 1:
        splashLoading = 0.1;
        break;
      case 2:
        splashLoading = 0.3;
        break;
      case 3:
        splashLoading = 0.6;
        break;
      case 4:
        splashLoading = 1;
        break;
      default:
        splashLoading = 0;
    }
  }

  // Others
  @action
  Future reloadView() async {
    _reload = true;
    Future.delayed(const Duration(milliseconds: 10), () {
      _reload = false;
    });
  }

  addReaction<T>(T Function(Reaction) fn, void Function(T) effect) {
    return reaction(fn, effect);
  }
}
