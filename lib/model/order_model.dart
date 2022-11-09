class OrderModel{
  String platform;
  String orderId;
  String trackingId;
  bool deliveryStatus;
  OrderModel({
    required this.platform,
    required this.orderId,
    required this.trackingId,
    required this.deliveryStatus,

  });

 static OrderModel fromJson(Map<String,dynamic>json){
    return OrderModel(
        platform: json["platform"],
        orderId: json["orderId"],
        trackingId: json["trackingId"],
        deliveryStatus:  json["deliveryStatus"]);
  }

 static toJson(OrderModel model){
    return {
      'platform':model.platform,
      'orderId':model.orderId,
      'trackingId':model.trackingId,
      'deliveryStatus':model.deliveryStatus
    };

  }

}