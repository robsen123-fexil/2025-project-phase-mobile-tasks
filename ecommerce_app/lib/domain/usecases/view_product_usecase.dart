import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:dartz/dartz.dart' as product;
import 'package:ecommerce_app/core/error/failures.dart';
import 'package:ecommerce_app/core/usecases/usecase.dart';
import 'package:ecommerce_app/domain/entities/product.dart';
import 'package:ecommerce_app/domain/repositories/product_repositories.dart';

class ViewProductUsecase implements UseCase<Product?, String> {
  final ProductRepository productRepository;

  ViewProductUsecase(this.productRepository);

  @override
  Future<Either<Failure, Product?>> call(String productId) async {
    return await productRepository.getProductById(productId);
  }
}
