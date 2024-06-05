import 'package:mockify/mockify.dart';
import 'package:test/test.dart';

final class AsyncService {
  AsyncService(this._mockify);

  final Mockify _mockify;

  Future<int?> fetchData() async => await _mockify.call<int>(#fetchData);
}

void main() {
  group('AsyncService tests', () {
    late Mockify mockify;
    late AsyncService asyncService;

    setUp(() {
      mockify = Mockify();
      asyncService = AsyncService(mockify);
    });

    test('Fetch data test', () async {
      mockify.when(#fetchData, (_) async => Future<int>.value(42));

      final result = await asyncService.fetchData();

      expect(result, equals(42));
    });

    test('Fetch data test with error', () async {
      mockify.when(#fetchData, (_) => throw Exception('Test error'));

      expect(() async => asyncService.fetchData(), throwsException);
    });
  });
}
