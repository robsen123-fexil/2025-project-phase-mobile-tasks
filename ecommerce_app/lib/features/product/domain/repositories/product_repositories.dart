import 'dart:core';

import 'package:ecommerce_app/core/error/failures.dart';
import 'package:ecommerce_app/domain/entities/product.dart';

import 'package:dartz/dartz.dart';

abstract class ProductRepositories {
  Future<Either<Failure, List<Product>>> getAllProducts();

  Future<Either<Failure, Product?>> getProductById(String  id);
  Future<Either<Failure, Product>> createProduct(Product product);
  Future<Either<Failure, Product>> updateProduct(Product  product);
  Future<Either<Failure, Unit>> deleteProduct(String id);
}
