import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';

import 'package:ecommerce_app/core/usecases/usecase.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/create_product_usecase.dart';
import 'package:ecommerce_app/features/product/domain/usecases/delete_product_usecase.dart';
import 'package:ecommerce_app/features/product/domain/usecases/update_product_usecase.dart';
import 'package:ecommerce_app/features/product/domain/usecases/view_all_products_use_case.dart';
import 'package:ecommerce_app/features/product/domain/usecases/view_product_usecase.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/product_bloc.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/product_event.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/product_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'bloc_product_test.mocks.dart';

@GenerateMocks([
  UpdateProductUsecase,
  DeleteProductUseCase,
  CreateProductUsecase,
  ViewAllProductsUsecase,
  ViewProductUsecase,
])
void main() {
  late UpdateProductUsecase updateProductUsecase;
  late DeleteProductUseCase deleteProductUseCase;
  late CreateProductUsecase createProductUsecase;
  late ViewAllProductsUsecase viewAllProductsUsecase;
  late ViewProductUsecase viewProductUsecase;
  late ProductBloc bloc;
  late Product tProduct;
  late List<Product> tProducts;

  setUp(() {
    updateProductUsecase = MockUpdateProductUsecase();
    deleteProductUseCase = MockDeleteProductUseCase();
    createProductUsecase = MockCreateProductUsecase();
    viewAllProductsUsecase = MockViewAllProductsUsecase();
    viewProductUsecase = MockViewProductUsecase();

    bloc = ProductBloc(
      updateProductUsecase: updateProductUsecase,
      deleteProductUsecase: deleteProductUseCase,
      createProductUsecase: createProductUsecase,
      getAllProductsUseCase: viewAllProductsUsecase,
      viewProductUsecase: viewProductUsecase,
    );

    tProduct = Product(
      id: '1',
      name: 'Test Product',
      description: 'Test Description',
      price: 100,
      imageUrl: 'https/image.com',
    );
    tProducts = [tProduct];
  });

  group('ProductBloc', () {
    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, LoadedAllProduct] when LoadAllProductEvent is added',
      build: () {
        when(
          viewAllProductsUsecase.call(NoParams()),
        ).thenAnswer((_) async => Right(tProducts));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadAllProductEvent()),
      expect: () => [LoadingState(), LoadedAllProduct(tProducts)],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, LoadedSingleProductState] when GetSingleProductEvent is added',
      build: () {
        when(
          viewProductUsecase.call('1'),
        ).thenAnswer((_) async => Right(tProduct));
        return bloc;
      },
      act: (bloc) => bloc.add(GetSingleProductEvent('1')),
      expect: () => [LoadingState(), LoadedSingleProductState(tProduct)],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, LoadedAllProduct] when CreateProductEvent is successful',
      build: () {
        when(
          createProductUsecase.call(tProduct),
        ).thenAnswer((_) async => Right(tProduct));
        when(
          viewAllProductsUsecase.call(NoParams()),
        ).thenAnswer((_) async => Right(tProducts));
        return bloc;
      },
      act: (bloc) => bloc.add(CreateProductEvent(tProduct)),
      expect:
          () => [LoadingState(), LoadingState(), LoadedAllProduct(tProducts)],
    );

    // blocTest<ProductBloc, ProductState>(
    //   'emits [LoadingState, LoadedAllProduct] when UpdateProductEvent is successful',
    //   build: () {
    //     when(
    //       updateProductUsecase.call(tProduct),
    //     ).thenAnswer((_) async => Right(tProduct));
    //     when(
    //       viewAllProductsUsecase.call(NoParams()),
    //     ).thenAnswer((_) async => Right(tProducts));
    //     return bloc;
    //   },
    //   act: (bloc) => bloc.add(UpdateProductEvent(tProduct)),
    //   expect:
    //       () => [LoadingState(), LoadingState(), LoadedAllProduct(tProducts)],
    // );

    // blocTest<ProductBloc, ProductState>(
    //   'emits [LoadingState, LoadedAllProduct] when DeleteProductEvent is successful',
    //   build: () {
    //     when(
    //       deleteProductUseCase.call(DeleteProductParams(productId: '1')),
    //     ).thenAnswer((_) async => const Right(unit));
    //     when(
    //       viewAllProductsUsecase.call(NoParams()),
    //     ).thenAnswer((_) async => Right(tProducts));
    //     return bloc;
    //   },
    //   act: (bloc) => bloc.add(DeleteProductEvent('1')),
    //   expect:
    //       () => [LoadingState(), LoadingState(), LoadedAllProduct(tProducts)],
    // );

    // blocTest<ProductBloc, ProductState>(
    //   'emits [LoadingState, ErrorState] when LoadAllProductEvent fails',
    //   build: () {
    //     when(
    //       viewAllProductsUsecase.call(NoParams()),
    //     ).thenAnswer((_) async => Left(ServerFailure('error')));
    //     return bloc;
    //   },
    //   act: (bloc) => bloc.add(LoadAllProductEvent()),
    //   expect: () => [LoadingState(), ErrorState('error')],
    // );
  });
}
