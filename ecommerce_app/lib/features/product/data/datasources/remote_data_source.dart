import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/exceptions.dart';
import 'package:ecommerce_app/features/product/data/models/product_models.dart';

import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:http/http.dart' as http;

abstract class ProductRemoteDataSource {
  Future<List<Product>> getAllProducts();
  Future<Product> getProductById(String id);
  Future<Product> createProduct(Product product);
  Future<Product> updateProduct(Product product);
  Future<Unit> deleteProduct(String id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;
  final String url;
  ProductRemoteDataSourceImpl({
    required this.client,
    this.url =
        'https://g5-flutter-learning-path-be.onrender.com/api/v1/products',
  });
  @override
  Future<List<Product>> getAllProducts() async {
    print('Making request to: $url');
    final response = await client.get(Uri.parse(url));
    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      try {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['data'] != null) {
          final List<dynamic> productsData = responseData['data'];
          return productsData
              .map((json) => ProductModel.fromJson(json))
              .toList();
        }
        throw ServerExceptions('No data field in response');
      } catch (e) {
        print('Error parsing response: $e');
        throw ServerExceptions('Failed to parse response: $e');
      }
    } else {
      throw ServerExceptions(
        'Server responded with status code: ${response.statusCode}',
      );
    }
  }

  @override
  Future<Product> getProductById(String id) async {
    final response = await client.get(Uri.parse('$url/$id'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['data'] != null) {
        return ProductModel.fromJson(responseData['data']);
      }
      throw ServerExceptions();
    } else {
      throw ServerExceptions();
    }
  }

  @override
  Future<Product> createProduct(Product product) async {
    final response = await client.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode((product as ProductModel).tojson()),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['data'] != null) {
        return ProductModel.fromJson(responseData['data']);
      }
      throw ServerExceptions();
    } else {
      throw ServerExceptions();
    }
  }

  @override
  Future<Product> updateProduct(Product product) async {
    final response = await client.put(
      Uri.parse('$url/${product.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode((product as ProductModel).tojson()),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['data'] != null) {
        return ProductModel.fromJson(responseData['data']);
      }
      throw ServerExceptions();
    } else {
      throw ServerExceptions();
    }
  }

  @override
  Future<Unit> deleteProduct(String id) async {
    final response = await client.delete(
      Uri.parse('$url/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 204 || response.statusCode == 200) {
      return unit;
    } else {
      throw ServerExceptions();
    }
  }
}
