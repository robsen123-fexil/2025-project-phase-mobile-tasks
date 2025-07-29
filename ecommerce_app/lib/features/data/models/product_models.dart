import 'package:ecommerce_app/features/product/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required String id,
    required String name,
    required String desription,
    required String imageUrl,
    required double price,
  }) : super(
         id: id,
         name: name,
         description: desription,
         imageUrl: imageUrl,
         price: price,
       );
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      
      name: json['name'] as String,
      desription: json['description'] as String,
      
      imageUrl: json['imageUrl'] as String,
      price: json['price'] as double,
    );
  }

  Map<String, dynamic> tojson() {
    return {
      'id': id,
      'description': description,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}
