// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppStore on _AppStoreBase, Store {
  Computed<SecureStorage>? _$secureStorageComputed;

  @override
  SecureStorage get secureStorage => (_$secureStorageComputed ??=
          Computed<SecureStorage>(() => super.secureStorage,
              name: '_AppStoreBase.secureStorage'))
      .value;
  Computed<API>? _$apiComputed;

  @override
  API get api => (_$apiComputed ??=
          Computed<API>(() => super.api, name: '_AppStoreBase.api'))
      .value;
  Computed<List<Server>>? _$serversComputed;

  @override
  List<Server> get servers =>
      (_$serversComputed ??= Computed<List<Server>>(() => super.servers,
              name: '_AppStoreBase.servers'))
          .value;
  Computed<bool>? _$reloadComputed;

  @override
  bool get reload => (_$reloadComputed ??=
          Computed<bool>(() => super.reload, name: '_AppStoreBase.reload'))
      .value;

  late final _$devAtom = Atom(name: '_AppStoreBase.dev', context: context);

  @override
  bool get dev {
    _$devAtom.reportRead();
    return super.dev;
  }

  @override
  set dev(bool value) {
    _$devAtom.reportWrite(value, super.dev, () {
      super.dev = value;
    });
  }

  late final _$serverFetchedAtom =
      Atom(name: '_AppStoreBase.serverFetched', context: context);

  @override
  bool get serverFetched {
    _$serverFetchedAtom.reportRead();
    return super.serverFetched;
  }

  @override
  set serverFetched(bool value) {
    _$serverFetchedAtom.reportWrite(value, super.serverFetched, () {
      super.serverFetched = value;
    });
  }

  late final _$_reloadAtom =
      Atom(name: '_AppStoreBase._reload', context: context);

  @override
  bool get _reload {
    _$_reloadAtom.reportRead();
    return super._reload;
  }

  @override
  set _reload(bool value) {
    _$_reloadAtom.reportWrite(value, super._reload, () {
      super._reload = value;
    });
  }

  late final _$stateAtom = Atom(name: '_AppStoreBase.state', context: context);

  @override
  AuthState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(AuthState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$fetchServersAsyncAction =
      AsyncAction('_AppStoreBase.fetchServers', context: context);

  @override
  Future<dynamic> fetchServers() {
    return _$fetchServersAsyncAction.run(() => super.fetchServers());
  }

  late final _$reloadViewAsyncAction =
      AsyncAction('_AppStoreBase.reloadView', context: context);

  @override
  Future<dynamic> reloadView() {
    return _$reloadViewAsyncAction.run(() => super.reloadView());
  }

  late final _$_AppStoreBaseActionController =
      ActionController(name: '_AppStoreBase', context: context);

  @override
  void setAppVersion(String appVersion) {
    final _$actionInfo = _$_AppStoreBaseActionController.startAction(
        name: '_AppStoreBase.setAppVersion');
    try {
      return super.setAppVersion(appVersion);
    } finally {
      _$_AppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeAuthenticationState(AuthState newState) {
    final _$actionInfo = _$_AppStoreBaseActionController.startAction(
        name: '_AppStoreBase.changeAuthenticationState');
    try {
      return super.changeAuthenticationState(newState);
    } finally {
      _$_AppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
dev: ${dev},
serverFetched: ${serverFetched},
state: ${state},
secureStorage: ${secureStorage},
api: ${api},
servers: ${servers},
reload: ${reload}
    ''';
  }
}
