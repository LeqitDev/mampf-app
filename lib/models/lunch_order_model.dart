import 'package:application/models/lunch_model.dart';

class LunchOrder extends Lunch {
  int orderId;
  LunchOrder(super.id, super.url, super.name, super.description, super.price,
      this.orderId);
}
