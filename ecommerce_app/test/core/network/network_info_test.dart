import 'package:ecommerce_app/core/platform/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helpers.mocks.dart';

@GenerateMocks([NetworkInfo]) // <-- Tell Mockito to generate the mock
void main() {
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();

    test('should return true when connected', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      // Act
      final result = await mockNetworkInfo.isConnected;

      // Assert
      expect(result, true);
    });
  });
}
