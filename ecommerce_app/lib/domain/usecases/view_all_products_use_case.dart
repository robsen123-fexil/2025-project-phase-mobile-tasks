import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failures.dart';
import 'package:ecommerce_app/core/usecases/usercase.dart';
import 'package:ecommerce_app/domain/entities/product.dart';
import 'package:ecommerce_app/domain/repositories/product_repositories.dart';

class ViewAllProductsUsecase implements UseCase<List<Product>, NoParams> {
  final ProductRepositories productRepository;

  ViewAllProductsUsecase(this.productRepository);

  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) {
    return productRepository.getAllProducts();
  }
}
