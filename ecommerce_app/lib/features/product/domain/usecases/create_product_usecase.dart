

import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failures.dart';

import 'package:ecommerce_app/core/usecases/usecase.dart';


import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repositories.dart';
class CreateProductUsecase implements UseCase<Product, Product> {
  final ProductRepository productRepository;

  CreateProductUsecase(this.productRepository);

  Future<Either<Failure, Product>> execute(Product product) {
    return productRepository.createProduct(product);
  }
  
   @override
  Future<Either<Failure, Product>> call(Product product) {
    return productRepository.createProduct(product);
  }
}
