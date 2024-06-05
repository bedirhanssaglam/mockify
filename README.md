# Mockify

Mockify is a Dart class used for mocking function calls and verifying method invocations.

## Basic Example


```dart
void main() {
  group('Calculator tests', () {
    late Mockify mockify;

    setUp(() {
      mockify = Mockify();
    });

    test('Subtract method test with negative result', () {
      mockify.when(#subtract, (args) => args[0] - args[1]);

      final resultSubtract = mockify.call<int>(#subtract, [2, 5]);
      expect(resultSubtract, -3);

      mockify.verify(#subtract, called: 1);
    });
  });
}
```

## Running Tests
To run tests, you can use the following command in the terminal at the root of project:

```bash
dart test
```

or

```bash
flutter test
```

These commands will find test files in project and report the test results.