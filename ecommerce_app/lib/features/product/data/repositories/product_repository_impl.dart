import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/exceptions.dart';
import 'package:ecommerce_app/core/error/failures.dart';
import 'package:ecommerce_app/core/network/network_info.dart';
import 'package:ecommerce_app/features/product/data/datasources/local_data_source.dart';
import 'package:ecommerce_app/features/product/data/datasources/remote_data_source.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repositories.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource productLocalDatasource;
  final ProductRemoteDataSource productRemoteDatasource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.productLocalDatasource,
    required this.productRemoteDatasource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Product>> createProduct(Product product) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await productRemoteDatasource.createProduct(
          product,
        );
        return Right(remoteProduct);
      } on ServerExceptions {
        return const Left(ServerFailure('server error'));
      }
    } else {
      return const Left(NetworkFailure('network error'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteProduct(String id) async {
    if (await networkInfo.isConnected) {
      try {
        await productRemoteDatasource.deleteProduct(id);
        return const Right(unit);
      } on ServerExceptions {
        return const Left(ServerFailure('server error'));
      }
    } else {
      return const Left(NetworkFailure('network error'));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await productRemoteDatasource.getAllProducts();

        await productLocalDatasource.cacheProducts(remoteProducts);
        return Right(remoteProducts);
      } on ServerExceptions {
        return const Left(ServerFailure('server error'));
      }
    } else {
      try {
        final cachedProducts = await productLocalDatasource.getAllProducts();
        return Right(cachedProducts);
      } on CacheExceptions {
        return const Left(CacheFailure('No cached products available'));
      }
    }
  }

  @override
  Future<Either<Failure, Product?>> getProductById(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final product = await productRemoteDatasource.getProductById(id);
        await productLocalDatasource.getcatchedProductByID(id);
        return Right(product);
      } on ServerExceptions {
        return const Left(ServerFailure('server error'));
      }
    } else {
      try {
        final product = await productLocalDatasource.getcatchedProductByID(id);
        return Right(product);
      } on CacheExceptions {
        return const Left(CacheFailure('No cached products available'));
      }
    }
  }

  @override
  Future<Either<Failure, Product>> updateProduct(Product product) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await productRemoteDatasource.updateProduct(
          product,
        );
        await productLocalDatasource.updateProduct(remoteProduct);
        return Right(remoteProduct);
      } on ServerExceptions {
        return const Left(ServerFailure('server error'));
      }
    } else {
      try {
        final localProduct = await productLocalDatasource.updateProduct(
          product,
        );
        return Right(localProduct);
      } on CacheExceptions {
        return const Left(CacheFailure('No cached products available'));
      }
    }
  }
}
