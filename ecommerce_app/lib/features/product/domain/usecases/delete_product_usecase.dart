

import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failures.dart';

import 'package:ecommerce_app/core/usecases/usecase.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repositories.dart';



class DeleteProductUseCase implements UseCase<Unit, DeleteProductParams> {
  final ProductRepository repository;

  DeleteProductUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(DeleteProductParams params) {
    return repository.deleteProduct(params.productId);
  }
}

