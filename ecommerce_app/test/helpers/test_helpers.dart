import 'package:ecommerce_app/core/platform/network_info.dart';
import 'package:ecommerce_app/features/product/data/datasources/local_data_source.dart';
import 'package:ecommerce_app/features/product/data/datasources/remote_data_source.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repositories.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

@GenerateMocks(
  [ProductRepository ,ProductRemoteDataSource, ProductLocalDataSource, NetworkInfo],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
