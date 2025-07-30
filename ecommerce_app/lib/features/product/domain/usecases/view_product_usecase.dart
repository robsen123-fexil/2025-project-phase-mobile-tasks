import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:dartz/dartz.dart' as product;
import 'package:ecommerce_app/core/error/failures.dart';
<<<<<<< HEAD:ecommerce_app/lib/domain/usecases/view_product_usecase.dart
import 'package:ecommerce_app/core/usecases/usecase.dart';
import 'package:ecommerce_app/domain/entities/product.dart';
import 'package:ecommerce_app/domain/repositories/product_repositories.dart';
=======
import 'package:ecommerce_app/core/usecases/usercase.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repositories.dart';
>>>>>>> 937bbfa (all tests passed on task10 with datalayer models):ecommerce_app/lib/features/product/domain/usecases/view_product_usecase.dart

class ViewProductUsecase implements UseCase<Product?, String> {
  final ProductRepository productRepository;

  ViewProductUsecase(this.productRepository);

  @override
  Future<Either<Failure, Product?>> call(String productId) async {
    return await productRepository.getProductById(productId);
  }
}
