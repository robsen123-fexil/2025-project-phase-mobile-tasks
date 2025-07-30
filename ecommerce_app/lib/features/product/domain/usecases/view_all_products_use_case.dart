import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failures.dart';
<<<<<<< HEAD:ecommerce_app/lib/domain/usecases/view_all_products_use_case.dart
import 'package:ecommerce_app/core/usecases/usecase.dart';
import 'package:ecommerce_app/domain/entities/product.dart';
import 'package:ecommerce_app/domain/repositories/product_repositories.dart';
=======
import 'package:ecommerce_app/core/usecases/usercase.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repositories.dart';
>>>>>>> 937bbfa (all tests passed on task10 with datalayer models):ecommerce_app/lib/features/product/domain/usecases/view_all_products_use_case.dart

class ViewAllProductsUsecase implements UseCase<List<Product>, NoParams> {
  final ProductRepository productRepository;

  ViewAllProductsUsecase(this.productRepository);

  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) {
    return productRepository.getAllProducts();
  }
}
