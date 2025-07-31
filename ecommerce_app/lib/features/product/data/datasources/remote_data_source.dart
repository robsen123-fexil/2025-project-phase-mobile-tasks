import 'package:dartz/dartz.dart';

import 'package:ecommerce_app/features/product/data/models/product_models.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel> getProductById(String id);
  Future<ProductModel> createProduct(Product product);
  Future<ProductModel> updateProduct(Product product);
  Future<Unit> deleteProduct(String id);
}
