import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failures.dart';
import 'package:ecommerce_app/core/usecases/usecase.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repositories.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/view_all_products_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helpers.mocks.dart';



@GenerateMocks([ProductRepository])
void main() {
  late ViewAllProductsUsecase usecase;
  late MockProductRepository mockProductRepositories;
 
  late List<Product> testProducts;

  setUp(() {
    mockProductRepositories = MockProductRepository();
    usecase = ViewAllProductsUsecase(mockProductRepositories as ProductRepository);

    testProducts = [
      Product(
        id: '1',
        name: 'name1',
        description: 'description 1',
        imageUrl: 'image1',
        price: 19.99,
      ),
      Product(
        id: '2',
        name: 'Water Bottle',
        description: '500ml stainless steel',
        imageUrl: 'bottle.jpg',
        price: 12.50,
      ),
      Product(
        id: '3',
        name: 'Notebook',
        description: 'Hardcover 120 pages',
        imageUrl: 'notebook.jpg',
        price: 8.99,
      ),
    ];
  });

  test('should return list of products from repository', () async {
    // Arrange
    when(
      mockProductRepositories.getAllProducts(),
    ).thenAnswer((_) async => Right(testProducts));

    // Act
    final result = await usecase(NoParams());

    // Assert
    expect(result, equals(Right(testProducts)));
    verify(mockProductRepositories.getAllProducts());
    verifyNoMoreInteractions(mockProductRepositories);
  });

  test('should return failure when repository fails', () async {
    // Arrange
    final failure = ServerFailure('server error');
    when(
      mockProductRepositories.getAllProducts(),
    ).thenAnswer((_) async => Left(failure));

    // Act
    final result = await usecase(NoParams());

    // Assert
    expect(result, equals(Left(failure)));
    verify(mockProductRepositories.getAllProducts());
    verifyNoMoreInteractions(mockProductRepositories);
  });
}
