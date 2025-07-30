import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/data/models/product_models.dart';

abstract class ProductLocalDataSource {
  Future<List<Product>> getAllProducts();
  Future<Product> getProductByID(String id);
  Future<Product> createProduct(ProductModel product);
  Future<Product> updateProduct(ProductModel product);
  Future<Unit> deleteProduct(String id);
  Future<List<Product>> getcatchedProducts(String id);
  Future<Product> getcatchedProductByID(String id);
  Future<void> addcacheProduct(Product product);
  Future<void> cacheProducts(List<Product> products);

}
