import 'dart:convert';

import 'package:ecommerce_app/features/product/data/datasources/local_data_source.dart';
import 'package:ecommerce_app/features/product/data/models/product_models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/test_helpers.mocks.dart';

void main() {
  late ProductLocalDatasourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;
  late List<ProductModel> testProducts;

  
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = ProductLocalDatasourceImpl(mockSharedPreferences);

    testProducts = [
      ProductModel(
        id: '1',
        name: 'Product 1',
        price: 10.0,
        
        imageUrl: 'http://example.com/image1.jpg', desription: 'description1',
      ),
      ProductModel(
        id: '2',
        name: 'Product 2',
        price: 20.0,
      
        imageUrl: 'http://example.com/image2.jpg', desription: 'description2',
      ),
    ];
  });

  test('should cache products using SharedPreferences', () async {
    // Arrange
    final expectedJson = json.encode(
      testProducts.map((e) => e.tojson()).toList(),
    );

    when(
      mockSharedPreferences.setString('CACHED_PRODUCTS', expectedJson),
    ).thenAnswer((_) async => true);

    // Act
    await dataSource.addcacheProducts(testProducts);

    // Assert
    verify(
      mockSharedPreferences.setString('CACHED_PRODUCTS', expectedJson),
    ).called(1);
  });

  test('should return single product by ID from local cache', () async {
    // Arrange
    final cachedJson = json.encode(
      testProducts.map((e) => e.tojson()).toList(),
    );

    when(
      mockSharedPreferences.getString('CACHED_PRODUCTS'),
    ).thenReturn(cachedJson);

    // Act
    final result = await dataSource.getcatchedProductByID('1');

    // Assert
    verify(mockSharedPreferences.getString('CACHED_PRODUCTS'));
    expect(result, isA<ProductModel>());
    expect(result.id, equals('1'));
  });
}
