import 'package:ecommerce_app/features/data/models/product_models.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final productModel = ProductModel(
    id: '1',
    name: 'name1',
    desription: 'description1',
    imageUrl: 'https/image.com',
    price: 1.0,
  );

  final jsonMap = {
    'id': '1',
    'name': 'name1',
    'description': 'description1',
    'imageUrl': 'https/image.com',
    'price': 1.0,
  };

  test('fromjson should return vald productmodel', () {
    final result = ProductModel.fromJson(jsonMap);
    expect(result, isA<Product>());
  });

  test('tojson should return a json map', () {
    final result = productModel.tojson();
    expect(result, jsonMap);
    
  });

 
}
