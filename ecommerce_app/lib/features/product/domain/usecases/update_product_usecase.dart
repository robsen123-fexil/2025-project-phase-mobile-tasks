
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failures.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repositories.dart';

class UpdateProductUsecase {
  final ProductRepositories repository;

  UpdateProductUsecase(this.repository);

  Future<Either<Failure , Product>> call(Product product) async{
    return await repository.updateProduct(product);
  }
}
