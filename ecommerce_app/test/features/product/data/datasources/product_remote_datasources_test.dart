import 'package:ecommerce_app/core/error/exceptions.dart';
import 'package:ecommerce_app/features/product/data/datasources/remote_data_source.dart';
import 'package:ecommerce_app/features/product/data/models/product_models.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';

@GenerateMocks([http.Client])
void main() {
  late ProductRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  const baseUrl = 'https://g5-flutter-learning-path-be.onrender.com/';
  const tProductId = '6672752cbd218790438efdb0';

  const testProducts = '''
  {
    "statusCode": 200,
    "message": "",
    "data": [
      {
        "id": "6672752cbd218790438efdb0",
        "name": "Anime website",
        "description": "Explore anime characters.",
        "price": 123,
        "imageUrl": "https://res.cloudinary.com/image.jpg"
      }
    ]
  }
  ''';

  const testSingleProduct = '''
  {
    "statusCode": 200,
    "message": "",
    "data": {
      "id": "6672752cbd218790438efdb0",
      "name": "Anime website",
      "description": "Explore anime characters.",
      "price": 123,
      "imageUrl": "https://res.cloudinary.com/image.jpg"
    }
  }
  ''';

  final tProductModel = ProductModel(
    id: "6672752cbd218790438efdb0",
    name: "Anime website",
    desription: "Explore anime characters.",
    price: 123,
    imageUrl: "https://res.cloudinary.com/image.jpg",
  );

  setUp(() {
    mockHttpClient = MockClient((request) async {
      // Default response for any unexpected requests
      return http.Response('{"statusCode": 404, "message": "Not found"}', 404);
    });

    dataSource = ProductRemoteDataSourceImpl(
      client: mockHttpClient,
      url: baseUrl,
    );
  });

  test('should return List<ProductModel> when response is 200', () async {
    // Arrange
    when(
      mockHttpClient.get(Uri.parse(baseUrl), headers: anyNamed('headers')),
    ).thenAnswer(
      (_) async => http.Response(
        testProducts,
        200,
        headers: {'content-type': 'application/json; charset=utf-8'},
      ),
    );

    // Act
    final result = await dataSource.getAllProducts();

    // Assert
    expect(result, isA<List<Product>>());
    expect(result.length, 1);
    expect(result[0].id, tProductModel.id);
    expect(result[0].name, tProductModel.name);
  });

  test('should return product when return 200', () async {
    // Arrange
    when(
      mockHttpClient.get(
        Uri.parse('$baseUrl/$tProductId'),
        headers: anyNamed('headers'),
      ),
    ).thenAnswer(
      (_) async => http.Response(
        testSingleProduct,
        200,
        headers: {'content-type': 'application/json; charset=utf-8'},
      ),
    );

    // Act
    final result = await dataSource.getProductById(tProductId);

    // Assert
    expect(result, isA<Product>());
    expect(result.id, tProductModel.id);
    expect(result.name, tProductModel.name);
  });

  test('should return productModel for the created product', () async {
    // Arrange
    when(
      mockHttpClient.post(
        Uri.parse(baseUrl),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      ),
    ).thenAnswer(
      (_) async => http.Response(
        testSingleProduct,
        201,
        headers: {'content-type': 'application/json'},
      ),
    );

    // Act
    final result = await dataSource.createProduct(tProductModel);

    // Assert
    expect(result, isA<ProductModel>());
  });

  test('should return updated product when the return is 200 ok', () async {
    // Arrange
    when(
      mockHttpClient.put(
        Uri.parse('$baseUrl/$tProductId'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      ),
    ).thenAnswer(
      (_) async => http.Response(
        testSingleProduct,
        200,
        headers: {'content-type': 'application/json'},
      ),
    );

    // Act
    final result = await dataSource.updateProduct(tProductModel);

    // Assert
    expect(result, isA<ProductModel>());
  });

  test('should throw serverException when the method rise exception', () async {
    // Arrange
    when(
      mockHttpClient.put(
        Uri.parse('$baseUrl/$tProductId'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
        encoding: anyNamed('encoding'),
      ),
    ).thenThrow(ServerExceptions());

    // Act
    final call = dataSource.updateProduct(tProductModel);

    // Assert
    expect(() => call, throwsA(isA<ServerExceptions>()));
  });

  test('should remove with id then return unit', () async {
    // Arrange
    when(
      mockHttpClient.delete(
        Uri.parse('$baseUrl/$tProductId'),
        headers: anyNamed('headers'),
      ),
    ).thenAnswer((_) async => http.Response('', 204));

    // Act
    final result = await dataSource.deleteProduct(tProductId);

    // Assert
    expect(result, unit);

    // Verify the delete method was called with the correct parameters
    verify(
      mockHttpClient.delete(
        Uri.parse('$baseUrl/$tProductId'),
        headers: anyNamed('headers'),
      ),
    );
  });
}
