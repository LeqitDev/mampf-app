import 'package:application/models/lunch_model.dart';
import 'package:application/models/lunch_order_model.dart';
import 'package:application/models/purchase_model.dart';

class User {
  String id;
  String name;
  String username;
  double? balance;
  List<Purchase>? purchases;
  List<Lunch>? lunches;
  List<LunchOrder>? lunchOrders;

  User(this.id, this.name, this.username);
}
