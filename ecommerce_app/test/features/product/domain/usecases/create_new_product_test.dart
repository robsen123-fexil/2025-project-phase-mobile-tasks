import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failures.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repositories.dart';
import 'package:ecommerce_app/features/product/domain/usecases/create_product_usecase.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helpers.mocks.dart';

@GenerateMocks([ProductRepository])
void main() {
  late CreateProduct usecase;
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
    usecase = CreateProduct(mockRepository as ProductRepository);
  });

  final testProduct = Product(
    id: '1',
    name: 'Test Product',
    description: 'Test Description',
    imageUrl: 'test.jpg',
    price: 49.99,
  );

  test('should add product via repository successfully', () async {
    // Arrange
    when(
      mockRepository.createProduct(testProduct),
    ).thenAnswer((_) async => Right(testProduct));

    // Act
    final result = await usecase.call(testProduct);

    // Assert
    expect(result, Right(testProduct));
    verify(mockRepository.createProduct(testProduct));
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return ServerFailure when repository fails', () async {
    // Arrange
    final failure = ServerFailure('Server error');
    when(
      mockRepository.createProduct(testProduct),
    ).thenAnswer((_) async => Left(failure));

    // Act
    final result = await usecase.call(testProduct);

    // Assert
    expect(result, Left(failure));
    verify(mockRepository.createProduct(testProduct));
    verifyNoMoreInteractions(mockRepository);
  });
}
