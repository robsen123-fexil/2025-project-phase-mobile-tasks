import 'package:dartz/dartz.dart';

import 'package:ecommerce_app/features/product/data/models/product_models.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';

abstract class ProductRemoteDataSource {
  Future<List<Product>> getAllProducts();
  Future<Product> getProductById(String id);
  Future<Product> createProduct(Product product);
  Future<Product> updateProduct(Product product);
  Future<Unit> deleteProduct(String id);
}
