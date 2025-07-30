

import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failures.dart';
import 'package:ecommerce_app/core/usecases/usecase.dart';
import 'package:ecommerce_app/domain/repositories/product_repositories.dart';


class DeleteProductUseCase implements UseCase<Unit, DeleteProductParams> {
  final ProductRepository repository;

  DeleteProductUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(DeleteProductParams params) async {
    final result = await repository.deleteProduct(params.productId);
    return result.fold((failure) => Left(failure), (product) => Right(unit));
  }
}

