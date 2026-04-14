import 'dart:convert';

class BestSellerResponse {
  int? status;
  String? message;
  BestSellerData? data;

  BestSellerResponse.fromJson(Map<String, dynamic>json){
    status=json['status'];
    message=json['message'];
    data=json['data']==null?null:BestSellerData.fromJson(json['data']);
  }



}

class BestSellerData{
  List <Product>? products;

  BestSellerData.fromJson(Map<String, dynamic>json){
    if(json["products"]!=null){
      products=[];
      json["products"].forEach((v){
        products?.add(Product.fromJson(v));
      });
    }
  }

}

class Product{
  int? id;
  String? name;
  String?title;
  String? description;
  String? price;
  num? discount;
  num? priceAfterDiscount;
  int? stock;
  String? image;
  String? category;

  Product.fromJson(Map<String, dynamic>tojson){
    id=tojson['id'];
    title=tojson['title'];
    name=tojson['name'];
    description=tojson['description'];
    price=tojson['price'];
    discount=tojson['discount'];
    priceAfterDiscount=tojson['price_after_discount'];
    stock=tojson['stock'];
    image=tojson['image'];
    category=tojson['category'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "image": image,
      "price": price,
      "description": description,
      "category": category,
    };
  }
}