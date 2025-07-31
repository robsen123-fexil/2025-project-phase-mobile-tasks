import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failures.dart' show ServerFailure;
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repositories.dart';
import 'package:ecommerce_app/features/product/domain/usecases/update_product_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helpers.mocks.dart';

@GenerateMocks([ProductRepository])
void main() {
  late UpdateProductUsecase usecase;
  late MockProductRepository mockRepository;

  final testProduct = Product(
    id: '1',
    name: 'Updated Name',
    description: 'Updated Description',
    imageUrl: 'updated_image.jpg',
    price: 79.99,
  );

  setUp(() {
    mockRepository = MockProductRepository();
    usecase = UpdateProductUsecase(mockRepository as ProductRepository);
  });

  test('should update product successfully via repository', () async {
    // arrange
    when(
      mockRepository.updateProduct(testProduct),
    ).thenAnswer((_) async => Right(testProduct));

    // act
    final result = await usecase(testProduct);

    // assert
    expect(result, Right(testProduct));
    verify(mockRepository.updateProduct(testProduct)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return failure when repository fails to update', () async {
    // arrange
    final failure = ServerFailure('Failed to update');
    when(
      mockRepository.updateProduct(testProduct),
    ).thenAnswer((_) async => Left(failure));

    // act
    final result = await usecase(testProduct);

    // assert
    expect(result, Left(failure));
    verify(mockRepository.updateProduct(testProduct)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
