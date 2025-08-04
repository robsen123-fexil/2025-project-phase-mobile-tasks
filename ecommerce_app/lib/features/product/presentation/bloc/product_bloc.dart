import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/error/failures.dart';
import 'package:ecommerce_app/core/usecases/usecase.dart';
import 'package:ecommerce_app/features/product/domain/usecases/create_product_usecase.dart';
import 'package:ecommerce_app/features/product/domain/usecases/delete_product_usecase.dart';
import 'package:ecommerce_app/features/product/domain/usecases/update_product_usecase.dart';
import 'package:ecommerce_app/features/product/domain/usecases/view_all_products_use_case.dart';
import 'package:ecommerce_app/features/product/domain/usecases/view_product_usecase.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/product_event.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ViewAllProductsUsecase getAllProductsUseCase;
  final CreateProductUsecase createProductUsecase;
  final DeleteProductUseCase deleteProductUsecase;
  final UpdateProductUsecase updateProductUsecase;
  final ViewProductUsecase viewProductUsecase;
   String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server failure';
      case CacheFailure:
        return 'Cache failure';
      default:
        return 'Unexpected error';
    }
  }
  ProductBloc({
    required this.getAllProductsUseCase,
    required this.createProductUsecase,
    required this.deleteProductUsecase,
    required this.viewProductUsecase,
    

    required this.updateProductUsecase,
  }) : super(InitialState()) {
    // alll products
    on<LoadAllProductEvent>((event, emit) async {
      emit(LoadingState());
      final result = await getAllProductsUseCase(NoParams());
      result.fold(
        (failure) => emit(ErrorState(_mapFailureToMessage(failure))),
        (products) => emit(LoadedAllProduct(products)),
      );
    });
 on<DeleteProductEvent>((event, emit) async {
      emit(LoadingState());
      final result = await deleteProductUsecase(
        DeleteProductParams(productId: event.productid),
      );
      result.fold(
        (failure) => emit(ErrorState(_mapFailureToMessage(failure))),
        (_) {
          // After successful deletion, reload all products
          add(LoadAllProductEvent());
        },
      );
    });
    on<UpdateProductEvent>((event, emit) async {
      emit(LoadingState());
      final result = await updateProductUsecase(event.product);
      result.fold(
        (failure) => emit(ErrorState(_mapFailureToMessage(failure))),
        (product) => emit(LoadedSingleProductState(product)),
      );
    }
    
    );
   
  }
}
