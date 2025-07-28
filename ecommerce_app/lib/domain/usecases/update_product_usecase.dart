
import 'package:ecommerce_app/domain/entities/product.dart';
import 'package:ecommerce_app/domain/repositories/product_repositories.dart';

class UpdateProductUsecase {
  final ProductRepositories repository;

  UpdateProductUsecase(this.repository);

  void call(Product product) {
    repository.updateProduct(product);
  }
}
