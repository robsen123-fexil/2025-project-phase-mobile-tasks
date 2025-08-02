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
  ProductRemoteDataSourceImpl(this.client, this.url);
  @override
  Future<List<Product>> getAllProducts() async {
    final response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw ServerExceptions();
    }
  }

  @override
  Future<Product> getProductById(String id) async {
    final response = await client.get(Uri.parse('$url/$id'));
    if (response.statusCode == 200) {
      final jsondata = json.decode(response.body);
      return ProductModel.fromJson(jsondata);
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
      final jsondata = json.decode(response.body);
      return ProductModel.fromJson(jsondata);
    } else {
      throw ServerExceptions();
    }
  }

  @override
  Future<Product> updateProduct(Product product) async {
    final response = await client.put(Uri.parse('$url/${product.id}'), body: json.encode((product as ProductModel).tojson()));
    if (response.statusCode == 200) {
      final jsondata = json.decode(response.body);
      return ProductModel.fromJson(jsondata);
    } else {
      throw ServerExceptions();
    }
  }

  @override
  Future<Unit> deleteProduct(String id) async {
    final response = await client.delete(Uri.parse('$url/$id'));
    if (response.statusCode == 204) {
      return unit;
    } else {
      throw ServerExceptions();
    }
  }
}
