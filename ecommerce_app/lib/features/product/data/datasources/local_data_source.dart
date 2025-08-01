import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';

abstract class ProductLocalDataSource {
  Future<List<Product>> getAllProducts();
  Future<Product> getProductByID(String id);
  Future<Product> createProduct(Product product);
  Future<Product> updateProduct(Product product);
  Future<Unit> deleteProduct(String id);
  Future<List<Product>> getcatchedProducts(String id);
  Future<Product> getcatchedProductByID(String id);
  Future<void> addcacheProduct(Product product);
  Future<void> cacheProducts(List<Product> products);
}
