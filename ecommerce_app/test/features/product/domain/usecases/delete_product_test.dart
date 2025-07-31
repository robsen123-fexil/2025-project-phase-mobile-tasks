import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/usecases/usecase.dart';
import 'package:ecommerce_app/features/product/domain/usecases/delete_product_usecase.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repositories.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helpers.mocks.dart';

@GenerateMocks([ProductRepository])
void main() {
  late DeleteProductUseCase deleteProductUsecase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    deleteProductUsecase = DeleteProductUseCase(mockProductRepository as ProductRepository);
  });

  const String productId = 'test_product_id';

  test('should call the repository with the correct id', () async {
    // Arrange
    when(
      mockProductRepository.deleteProduct(productId),
    ).thenAnswer((_) async => const Right(unit)); //Changed to const Right(unit)

    // Act
    final result = await deleteProductUsecase(
      DeleteProductParams(productId: productId),
    ); // Corrected this line

    // Assert
    expect(result, const Right(unit));
    verify(mockProductRepository.deleteProduct(productId));
    verifyNoMoreInteractions(mockProductRepository);
  });
}
