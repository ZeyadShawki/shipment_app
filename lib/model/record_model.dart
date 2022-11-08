class RecordModel{
  String name;
  int quantity;
  String image;
  RecordModel({
    required this.image,
    required this.name,
    required this.quantity
});

 static RecordModel fromJson(Map<String,dynamic> json){
    return RecordModel(
    image: json["image"],
    name: json["name"],
    quantity: json["quantity"]);
  }

  toJson(RecordModel model){
    return {
      "image":model.image,
      "name":model.name,
      "quantity":model.quantity,
    };
  }


}