import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/exceptions.dart';
import 'package:ecommerce_app/features/product/data/models/product_models.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProductLocalDataSource {
  Future<List<Product>> getAllProducts();
  Future<Product> getProductByID(String id);
  Future<Product> createProduct(Product product);
  Future<Product> updateProduct(Product product);
  Future<void> deleteProduct(String id);
  Future<List<Product>> getcatchedProducts(String id);
  Future<Product> getcatchedProductByID(String id);
  Future<void> addcacheProduct(ProductModel product);
  Future<void> cacheProducts(List<Product> products);
  Future<void> addcacheProducts(List<ProductModel> products);
}

class ProductLocalDatasourceImpl implements ProductLocalDataSource {
  SharedPreferences sharedPreferences;
  ProductLocalDatasourceImpl(this.sharedPreferences);

  @override
  Future<void> cacheProducts(List<Product> products) {
    // TODO: implement cacheProducts
    throw UnimplementedError();
  }

  @override
  Future<void> deleteProduct(String id) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('CACHED_PRODUCTS');
  }

  //second
  @override
  Future<List<Product>> getAllProducts() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? cachedProductsJson = preferences.getString('CACHED_PRODUCTS');
    if (cachedProductsJson != null) {
      try {
        final List<dynamic> productsList = json.decode(cachedProductsJson);

        // Convert each item to Product
        return productsList
            .map((productJson) => ProductModel.fromJson(productJson))
            .toList();
      } catch (e) {
        throw CacheExceptions();
      }
    } else {
      throw CacheExceptions();
    }
  }

  // done one
  @override
  Future<Product> getProductByID(String id) async {
    final List<Product> products = (await getProductByID(id)) as List<Product>;
    Product product = products.firstWhere(
      (product) => id == product.id,
      orElse: () => throw CacheExceptions(),
    );
    return product;
  }

  @override
  Future<Product> updateProduct(Product product) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }
  // third

  // Future<void> addcacheProduct(ProductModel products) async {
  //    final SharedPreferences preferences = await SharedPreferences.getInstance();
  //   final String productsJson = json.encode(products.map((product) => product.toJson()).toList(),
  //   );

  //   if (products.isNotEmpty) {
  //     await preferences.setString('CACHED_PRODUCTS', productsJson);
  //   } else {
  //     throw CacheExceptions();
  //   }
  // }
  @override
  Future<void> addcacheProduct(ProductModel products) async {
    // TODO: implement createProduct
    throw UnimplementedError();
  }

  @override
  Future<Product> createProduct(Product product) {
    // TODO: implement createProduct
    throw UnimplementedError();
  }

  @override
  Future<Product> getcatchedProductByID(String id) {
    // TODO: implement getcatchedProductByID
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getcatchedProducts(String id) {
    // TODO: implement getcatchedProducts
    throw UnimplementedError();
  }

  @override
  Future<void> addcacheProducts(List<ProductModel> products) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String productsJson = json.encode(
      products.map((product) => product.tojson()).toList(),
    );

    if (products.isNotEmpty) {
      await preferences.setString('CACHED_PRODUCTS', productsJson);
    } else {
      throw CacheExceptions();
    }
  }
}
