import 'package:intl/intl.dart';

class OrderModel implements Comparable<OrderModel> {
  String platform;
  String orderId;
  String trackingId;
  bool deliveryStatus;
  String orderDate;
  String orderQuantity;
  String name;
  OrderModel({
    required this.platform,
    required this.orderId,
    required this.trackingId,
    required this.deliveryStatus,
    required this.orderDate,
    required this.orderQuantity,
    required this.name,
  });

  static OrderModel fromJson(Map<String, dynamic> json) {
    return OrderModel(
      platform: json["platform"],
      orderId: json["orderId"],
      trackingId: json["trackingId"],
      deliveryStatus: json["deliveryStatus"],
      orderDate: json["orderDate"],
      orderQuantity: json["orderQuantity"],
      name: json['name'],
    );
  }

  static toJson(OrderModel model) {
    return {
      'platform': model.platform,
      'orderId': model.orderId,
      'trackingId': model.trackingId,
      'deliveryStatus': model.deliveryStatus,
      'orderDate': model.orderDate,
      'orderQuantity': model.orderQuantity,
      'name': model.name,
    };
  }

  @override
  int compareTo(OrderModel other) {
    DateFormat format = DateFormat("dd-MM-yyyy");
    final thisTime = format.parse(orderDate);
    final otherDate = format.parse(other.orderDate);
    return thisTime.compareTo(otherDate);
  }
}
