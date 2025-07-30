

import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failures.dart';
<<<<<<< HEAD:ecommerce_app/lib/domain/usecases/create_product_usecase.dart
import 'package:ecommerce_app/core/usecases/usecase.dart';
import 'package:ecommerce_app/domain/entities/product.dart';
import 'package:ecommerce_app/domain/repositories/product_repositories.dart';
=======
import 'package:ecommerce_app/core/usecases/usercase.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repositories.dart';
>>>>>>> 937bbfa (all tests passed on task10 with datalayer models):ecommerce_app/lib/features/product/domain/usecases/create_product_usecase.dart
abstract class CreateProductUsecase implements UseCase<Product, Product> {
  final ProductRepository productRepository;

  CreateProductUsecase(this.productRepository);

  Future<Either<Failure, Product>> execute(Product product) {
    return productRepository.createProduct(product);
  }
}
class CreateProduct extends CreateProductUsecase {
  CreateProduct(ProductRepository repository) : super(repository);

  @override
  Future<Either<Failure, Product>> call(Product product) {
    return productRepository.createProduct(product);
  }
}
