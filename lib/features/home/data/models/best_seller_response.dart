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
  String? description;
  String? price;
  num? discount;
  num? priceAfterDiscount;
  int? stock;
  String? image;
  String? category;

  Product.fromJson(Map<String, dynamic>json){
    id=json['id'];
    name=json['name'];
    description=json['description'];
    price=json['price'];
    discount=json['discount'];
    priceAfterDiscount=json['price_after_discount'];
    stock=json['stock'];
    image=json['image'];
    category=json['category'];
  }
}