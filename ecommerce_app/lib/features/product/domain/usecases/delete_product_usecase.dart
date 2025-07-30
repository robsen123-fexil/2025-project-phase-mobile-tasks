

import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failures.dart';
<<<<<<< HEAD:ecommerce_app/lib/domain/usecases/delete_product_usecase.dart
import 'package:ecommerce_app/core/usecases/usecase.dart';
import 'package:ecommerce_app/domain/repositories/product_repositories.dart';
=======
import 'package:ecommerce_app/core/usecases/usercase.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repositories.dart';
>>>>>>> 937bbfa (all tests passed on task10 with datalayer models):ecommerce_app/lib/features/product/domain/usecases/delete_product_usecase.dart


class DeleteProductUseCase implements UseCase<Unit, DeleteProductParams> {
  final ProductRepository repository;

  DeleteProductUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(DeleteProductParams params) async {
    final result = await repository.deleteProduct(params.productId);
    return result.fold((failure) => Left(failure), (product) => Right(unit));
  }
}

