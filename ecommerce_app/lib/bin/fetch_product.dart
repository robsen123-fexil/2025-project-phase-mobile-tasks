import 'package:ecommerce_app/features/product/data/datasources/remote_data_source.dart';
import 'package:http/http.dart' as http;

void main() async {
  final dataSource = ProductRemoteDataSourceImpl(client: http.Client());

  try {
    print('Fetching products...');
    final products = await dataSource.getAllProducts();
    print('Successfully fetched ${products.length} products:');
    for (var product in products) {
      print('\nProduct ID: ${product.id}');
      print('Name: ${product.name}');
      print('Price: \$${product.price}');
      print('Description: ${product.description}');
      print('-------------------');
    }
  } catch (e) {
    print('Error fetching products: $e');
  }
}
