import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failures.dart';
import 'package:ecommerce_app/domain/entities/product.dart';
import 'package:ecommerce_app/domain/repositories/product_repositories.dart';
import 'package:ecommerce_app/domain/usecases/view_product_usecase.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helpers.mocks.dart';

@GenerateMocks([ProductRepository])
void main() {
  late ViewProductUsecase usecase;
  late MockProductRepository mockRepository;

  const productId = '1';
  final product = Product(
    id: productId,
    name: 'Test Product',
    description: 'Description',
    imageUrl: 'image.jpg',
    price: 99.99,
  );

  setUp(() {
    mockRepository = MockProductRepository();
    usecase = ViewProductUsecase(mockRepository);
  });

  test('should return product when found by ID', () async {
    when(
      mockRepository.getProductById(productId),
    ).thenAnswer((_) async => Right(product));

    final result = await usecase(productId);

    expect(result, Right(product));
    verify(mockRepository.getProductById(productId));
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return failure when not found or error', () async {
    final failure = ServerFailure('Not Found');
    when(
      mockRepository.getProductById(productId),
    ).thenAnswer((_) async => Left(failure));

    final result = await usecase(productId);

    expect(result, Left(failure));
    verify(mockRepository.getProductById(productId));
    verifyNoMoreInteractions(mockRepository);
  });
}
