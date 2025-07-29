

import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failures.dart';
import 'package:ecommerce_app/core/usecases/usercase.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repositories.dart';
abstract class CreateProductUsecase implements UseCase<Product, Product> {
  final ProductRepositories productRepository;

  CreateProductUsecase(this.productRepository);

  Future<Either<Failure, Product>> Execute(Product product) {
    return productRepository.createProduct(product);
  }
}
