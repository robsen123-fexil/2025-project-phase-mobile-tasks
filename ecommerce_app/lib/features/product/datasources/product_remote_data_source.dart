import 'package:dartz/dartz.dart';

import 'package:ecommerce_app/features/product/data/models/product_models.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel> getProductById(String id);
  Future<ProductModel> createProduct(ProductModel product);
  Future<ProductModel> updateProduct(ProductModel product);
  Future<Unit> deleteProduct(String id);
}