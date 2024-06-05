import 'package:mockify/mockify.dart';
import 'package:test/test.dart';

void main() {
  group('Calculator tests', () {
    late Mockify mockify;

    setUp(() {
      mockify = Mockify();
    });

    test('Add method test', () {
      mockify.when(#add, (args) => args[0] + args[1]);

      final resultAdd = mockify.call<int>(#add, [2, 3]);
      expect(resultAdd, equals(5), reason: 'Adding 2 and 3 should result in 5');
      expect(resultAdd, isNot(equals(6)), reason: 'Adding 2 and 3 should not result in 6');
      expect(resultAdd, greaterThanOrEqualTo(5), reason: 'Result should be greater than or equal to 5');
      expect(resultAdd, lessThanOrEqualTo(5), reason: 'Result should be less than or equal to 5');
      expect(resultAdd, isNot(lessThan(4)), reason: 'Result should not be less than 4');
      expect(resultAdd, isNot(greaterThan(6)), reason: 'Result should not be greater than 6');
      expect(resultAdd, closeTo(5, 0.01), reason: 'Result should be close to 5 within a tolerance of 0.01');
      expect(resultAdd, isNonZero, reason: 'Result should be non-zero');
      expect(resultAdd, isNonNegative, reason: 'Result should be non-negative');
      expect(resultAdd, isIn([5, 6, 7]), reason: 'Result should be one of [5, 6, 7]');
      expect(resultAdd, isPositive, reason: 'Result should be positive');

      mockify.verify(#add, called: 1);
      mockify.verifyNever(#subtract);
    });

    test('Subtract method test', () {
      mockify.when(#subtract, (args) => args[0] - args[1]);

      final resultSubtract = mockify.call<int>(#subtract, [5, 2]);
      expect(resultSubtract, isA<int>(), reason: 'Result of subtracting 5 and 2 should be an integer');
      expect(resultSubtract, equals(3), reason: 'Subtracting 5 and 2 should result in 3');
      expect(resultSubtract, isNot(equals(4)), reason: 'Subtracting 5 and 2 should not result in 4');
      expect(resultSubtract, lessThan(5), reason: 'Result should be less than 5');
      expect(resultSubtract, greaterThan(2), reason: 'Result should be greater than 2');
      expect(resultSubtract, closeTo(3, 0.01), reason: 'Result should be close to 3 within a tolerance of 0.01');
      expect(resultSubtract, isNonZero, reason: 'Result should be non-zero');
      expect(resultSubtract, isNonNegative, reason: 'Result should be non-negative');

      mockify.verify(#subtract, called: 1);
      mockify.verifyNever(#add);
    });

    test('Add method test with negative numbers', () {
      mockify.when(#add, (args) => args[0] + args[1]);

      final resultAdd = mockify.call<int>(#add, [-2, 3]);
      expect(resultAdd, equals(1));

      mockify.verify(#add, called: 1);
    });

    test('Subtract method test with negative result', () {
      mockify.when(#subtract, (args) => args[0] - args[1]);

      final resultSubtract = mockify.call<int>(#subtract, [2, 5]);
      expect(resultSubtract, -3);

      mockify.verify(#subtract, called: 1);
    });

    test('Add method test with zero', () {
      mockify.when(#add, (args) => args[0] + args[1]);

      final resultAdd = mockify.call<int>(#add, [0, 5]);
      expect(resultAdd, equals(5));

      mockify.verify(#add, called: 1);
    });

    test('Subtract method test with zero', () {
      mockify.when(#subtract, (args) => args[0] - args[1]);

      final resultSubtract = mockify.call<int>(#subtract, [5, 0]);
      expect(resultSubtract, equals(5));

      mockify.verify(#subtract, called: 1);
    });

    test('Add method test with large numbers', () {
      mockify.when(#add, (args) => args[0] + args[1]);

      final resultAdd = mockify.call<int>(#add, [1000000, 2000000]);
      expect(resultAdd, equals(3000000));

      mockify.verify(#add, called: 1);
    });

    test('Subtract method test with large numbers', () {
      mockify.when(#subtract, (args) => args[0] - args[1]);

      final resultSubtract = mockify.call<int>(#subtract, [1000000, 500000]);
      expect(resultSubtract, equals(500000));

      mockify.verify(#subtract, called: 1);
    });

    test('Add method test with decimal numbers', () {
      mockify.when(#add, (args) => args[0] + args[1]);

      final resultAdd = mockify.call<double>(#add, [1.5, 2.5]);
      expect(resultAdd, equals(4));

      mockify.verify(#add, called: 1);
    });

    test('Subtract method test with decimal result', () {
      mockify.when(#subtract, (args) => args[0] - args[1]);

      final resultSubtract = mockify.call<double>(#subtract, [5.5, 2.5]);
      expect(resultSubtract, 3);

      mockify.verify(#subtract, called: 1);
    });

    test('Add method test with zero result', () {
      mockify.when(#add, (args) => args[0] + args[1]);

      final resultAdd = mockify.call<int>(#add, [0, 0]);
      expect(resultAdd, 0);

      mockify.verify(#add, called: 1);
    });

    test('Subtract method test with zero result', () {
      mockify.when(#subtract, (args) => args[0] - args[1]);

      final resultSubtract = mockify.call<int>(#subtract, [5, 5]);
      expect(resultSubtract, 0);

      mockify.verify(#subtract, called: 1);
    });
  });
}
