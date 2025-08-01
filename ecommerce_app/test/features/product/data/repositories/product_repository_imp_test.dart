import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/exceptions.dart';
import 'package:ecommerce_app/core/error/failures.dart';
import 'package:ecommerce_app/core/network/network_info.dart';

import 'package:ecommerce_app/features/product/data/datasources/local_data_source.dart';
import 'package:ecommerce_app/features/product/data/datasources/remote_data_source.dart';

import 'package:ecommerce_app/features/product/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helpers.mocks.dart';

@GenerateMocks([ProductRemoteDataSource, ProductLocalDataSource, NetworkInfo])
void main() {
  late MockProductRemoteDataSource mockRemoteDatasource;
  late MockProductLocalDataSource mockLocalDatasource;
  late MockNetworkInfo mockNetworkInfo;
  late ProductRepositoryImpl repository;

  final tProductModels = [
    Product(
      id: '1',
      name: 'Test Product',
      price: 10.0,
      description: 'Test Description',
      imageUrl: 'http://example.com/image.jpg',
    ),
    Product(
      id: '2',
      name: 'Second Product',
      price: 24.5,
      description: 'Description',
      imageUrl: 'imageUrl',
    ),
  ];

  setUp(() {
    mockRemoteDatasource = MockProductRemoteDataSource();
    mockLocalDatasource = MockProductLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ProductRepositoryImpl(
      productRemoteDatasource: mockRemoteDatasource,
      productLocalDatasource: mockLocalDatasource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestOnline(void Function() body) {
    group('online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestOffline(void Function() body) {
    group('offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  runTestOffline(() {
    test('should return cached products when offline', () async {
      when(
        mockLocalDatasource.getAllProducts(),
      ).thenAnswer((_) async => tProductModels);

      final result = await repository.getAllProducts();

      verify(mockLocalDatasource.getAllProducts());
      expect(result, Right(tProductModels));
    });

    test('should return single product from cache when offline', () async {
      when(mockLocalDatasource.getProductByID('1')).thenAnswer(
        (_) async => tProductModels[0],
      ); // keep for backward compatibility
      when(
        mockLocalDatasource.getcatchedProductByID('1'),
      ).thenAnswer((_) async => tProductModels[0]);

      final result = await repository.getProductById('1');

      verify(mockLocalDatasource.getcatchedProductByID('1'));
      expect(result, Right(tProductModels[0]));
    });

    test('should return CacheFailure when cache fails', () async {
      when(mockLocalDatasource.getAllProducts()).thenThrow(CacheExceptions());

      final result = await repository.getAllProducts();

      verify(mockLocalDatasource.getAllProducts());
      expect(result, const Left(CacheFailure('No cached products available')));
    });
  });

  runTestOnline(() {
    test('should return products from remote when online', () async {
      when(
        mockRemoteDatasource.getAllProducts(),
      ).thenAnswer((_) async => tProductModels);

      final result = await repository.getAllProducts();

      verify(mockRemoteDatasource.getAllProducts());
      expect(result, Right(tProductModels));
    });

    test('should return single product from remote when online', () async {
      when(
        mockRemoteDatasource.getProductById('1'),
      ).thenAnswer((_) async => tProductModels[0]);
      when(
        mockLocalDatasource.getcatchedProductByID('1'),
      ).thenAnswer((_) async => tProductModels[0]);

      final result = await repository.getProductById('1');

      verify(mockRemoteDatasource.getProductById('1'));
      expect(result, Right(tProductModels[0]));
    });

    test('should return created product from remote', () async {
      when(
        mockRemoteDatasource.createProduct(tProductModels[0]),
      ).thenAnswer((_) async => tProductModels[0]);

      final result = await repository.createProduct(tProductModels[0]);

      verify(mockRemoteDatasource.createProduct(tProductModels[0]));
      expect(result, Right(tProductModels[0]));
    });

    test('should return updated product from remote', () async {
      when(
        mockRemoteDatasource.updateProduct(tProductModels[0]),
      ).thenAnswer((_) async => tProductModels[0]);
      when(
        mockLocalDatasource.updateProduct(tProductModels[0]),
      ).thenAnswer((_) async => tProductModels[0]);

      final result = await repository.updateProduct(tProductModels[0]);

      verify(mockRemoteDatasource.updateProduct(tProductModels[0]));
      expect(result, Right(tProductModels[0]));
    });

    test('should return unit when deleting product', () async {
      when(
        mockRemoteDatasource.deleteProduct('1'),
      ).thenAnswer((_) async => unit);

      final result = await repository.deleteProduct('1');

      verify(mockRemoteDatasource.deleteProduct('1'));
      expect(result, const Right(unit));
    });

    test('should return ServerFailure when remote throws error', () async {
      when(mockRemoteDatasource.getAllProducts()).thenThrow(ServerExceptions());

      final result = await repository.getAllProducts();

      verify(mockRemoteDatasource.getAllProducts());
      expect(result, const Left(ServerFailure('server error')));
    });
  });
}
