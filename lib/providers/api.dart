import 'dart:collection';
import 'dart:math';

import 'package:application/core/utils.dart';
import 'package:application/models/lunch_model.dart';
import 'package:application/models/lunch_order_model.dart';
import 'package:application/models/purchase_model.dart';
import 'package:application/models/user_model.dart';
import 'package:pocketbase/pocketbase.dart';

class APIResponse<T> {
  int? responseCode;
  String? responseMessage;
  T? responseObject;
}

class API {
  // final pb = PocketBase('http://10.0.2.2:8090/');
  var pb = PocketBase('http://127.0.0.1:8090');
  bool ready = false;
  User? user;

  Future<APIResponse<void>> init() async {
    return pb
        .collection('users')
        .authWithPassword('app', 'zjg2znj*ykf!mkj1QTQ')
        .then((value) => APIResponse()
          ..responseCode = 0
          ..responseMessage = "OK")
        .onError((error, stackTrace) => APIResponse()
          ..responseCode = 1
          ..responseMessage = "Error on Authentication: Something went wrong");
  }

  Future<APIResponse<void>> connectToMampfServer(
      String apiUrl, String username, String password) async {
    pb = PocketBase(apiUrl);
    return pb
        .collection('users')
        .authWithPassword(username, password)
        .then((value) async {
      user = User(
          value.record!.toJson()["id"],
          value.record!.getStringValue("name"),
          value.record!.getStringValue("username"));

      await loadUserData(user);
      loadLunchData();
      // loadSnackData();

      return APIResponse()
        ..responseCode = 0
        ..responseMessage = "OK";
    }).onError((error, stackTrace) => APIResponse()
          ..responseCode = 1
          ..responseMessage =
              "Error on Authentication: Something went wrong (${error})");
  }

  Future<HashMap<String, String>> getServers() async {
    final result = await pb.collection('locations').getFullList();
    HashMap<String, String> list = HashMap();

    for (RecordModel entry in result) {
      list.addAll({entry.getStringValue('name'): entry.getStringValue('api')});
    }

    return list;
  }

  Future<void> loadUserData(user) async {
    await pb
        .collection("credits")
        .getFirstListItem('user = "${user.id}"')
        .then((value) => user.balance = value.getDoubleValue("balance"))
        .onError((error, stackTrace) {
      print("Credits: $error");
      return -1;
    });
    await pb
        .collection("purchases")
        .getFullList(filter: 'user = "${user.id}"')
        .then((value) => _parsePurchases(value))
        .onError((error, stackTrace) => print("Purchases: $error"));
  }

  Future<void> loadLunchData() async {
    var now = DateTime.now();
    var nextDay = now.add(const Duration(days: 1));
    print(
        'created >= "${getDatabaseDate(now)}" && created < "${getDatabaseDate(nextDay)}"');
    await pb
        .collection("lunches")
        .getFullList(
            filter:
                'created >= "${getDatabaseDate(now)}" && created < "${getDatabaseDate(nextDay)}"')
        .then((value) {
      _parseLunches(value);
    }).onError((error, stackTrace) {
      print("Error on fetching lunches: $error");
    });
  }

  Future<void> loadOrders() async {
    // Load lunch orders
    await pb
        .collection("lunch_orders")
        .getFullList(filter: 'user == "${user!.id}"')
        .then((value) => _parseLunchOrders(value))
        .onError((error, stackTrace) =>
            {print("Error on fetching lunch orders: $error")});
  }

  _parsePurchases(List<RecordModel> purchases) {
    List<Purchase> _purchases = [];
    for (var element in purchases) {
      _purchases.add(Purchase(
          element.getStringValue("name"),
          element.getStringValue("categorie"),
          element.getDoubleValue("price"),
          element.getDoubleValue("balance"),
          element.getStringValue("created")));
    }
    user!.purchases = _purchases;
  }

  _parseLunch(RecordModel lunch) {
    return Lunch(
        lunch.getStringValue("id"),
        pb.getFileUrl(lunch, lunch.getStringValue("image")).toString(),
        lunch.getStringValue("name"),
        lunch.getStringValue("discription"),
        lunch.getDoubleValue("price"));
  }

  _parseLunches(List<RecordModel> lunches) {
    List<Lunch> _lunches = [];
    for (var lunch in lunches) {
      _lunches.add(_parseLunch(lunch));
    }
    user!.lunches = _lunches;
  }

  _parseLunchOrders(List<RecordModel> lunchOrders) async {
    List<LunchOrder> _lunchOrders = [];
    for (var element in lunchOrders) {
      Lunch? lunch;
      await pb
          .collection("lunches")
          .getOne(element.getStringValue("lunch"))
          .then((lunch) => lunch = _parseLunch(lunch))
          .onError((error, stackTrace) =>
              {print("Error on fetching lunch: $error")});
      _lunchOrders.add(LunchOrder(lunch!.id, lunch.url, lunch.name,
          lunch.description, lunch.price, element.getIntValue("order_id")));
    }
    user!.lunchOrders = _lunchOrders;
  }

  Future<void> orderLunch(Lunch lunch) async {
    var order_ids = Iterable.generate(301, (x) => x).toList();
    var exclude = <int>[];
    await pb.collection("lunch_orders").getFullList().then((value) {
      for (var element in value) {
        exclude.add(element.getIntValue("order_id"));
      }
    });
    order_ids =
        order_ids.where((element) => !exclude.contains(element)).toList();
    int order_id = order_ids[Random().nextInt(order_ids.length)];

    await pb.collection("lunch_orders").create(
      body: <String, dynamic>{
        "user": user!.id,
        "lunch": lunch.id,
        "order_id": order_id,
      },
    );
  }

  Future<double> getCurrentBalance() async {
    return 0;
  }
}
