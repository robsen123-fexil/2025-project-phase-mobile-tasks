

import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failures.dart';
import 'package:ecommerce_app/core/usecases/usercase.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repositories.dart';

class DeleteProductUsecase implements UseCase<Product, Product> {
  final ProductRepositories repository;

  DeleteProductUsecase(this.repository);

  @override
  Future<Either<Failure, Product>> call(Product product) async {
    final result = await repository.deleteProduct(product.id  );
    return result.fold((failure) => Left(failure), (_) => Right(product));
  }
}
