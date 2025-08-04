import 'dart:convert';

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
  Future<void> cacheProducts(List<Product> products) =>
      addcacheProducts(products.map((p) => p as ProductModel).toList());

  @override
  Future<void> deleteProduct(String id) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('CACHED_PRODUCTS');
  }

  //second
  @override
  Future<List<Product>> getAllProducts() async {
    final String? cachedJson = sharedPreferences.getString('CACHED_PRODUCTS');
    if (cachedJson == null) throw CacheExceptions();

    try {
      final list = json.decode(cachedJson) as List<dynamic>;
      return list.map((e) => ProductModel.fromJson(e)).toList();
    } catch (_) {
      throw CacheExceptions();
    }
  }

  // done one
  @override
  Future<Product> getProductByID(String id) async {
    final products = await getAllProducts();
    return products.firstWhere(
      (p) => p.id == id,
      orElse: () => throw CacheExceptions(),
    );
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
    final List<Product> current = await getAllProducts().catchError(
      (_) => <ProductModel>[],
    );
    await addcacheProducts([
      ...current.map((p) => p as ProductModel),
      products,
    ]);
  }

  @override
  Future<Product> createProduct(Product product) async {
    await addcacheProduct(product as ProductModel); // cache it
    return product; // return it back
  }

  @override
  Future<Product> getcatchedProductByID(String id) async {
    return getProductByID(id);
  }

  @override
  Future<List<Product>> getcatchedProducts(String id) async {
    final product = await getProductByID(id);
    return [product];
  }

  @override
  Future<void> addcacheProducts(List<ProductModel> models) async {
    final jsonString = json.encode(models.map((m) => m.tojson()).toList());
    await sharedPreferences.setString('CACHED_PRODUCTS', jsonString);
  }
}
