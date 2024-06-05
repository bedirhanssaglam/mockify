import 'dart:async' show FutureOr;

/// A typedef for mock functions that take a list of dynamic arguments.
typedef MockFunction = FutureOr<void> Function(List<dynamic> args);

/// A class for mocking function calls and verifying method invocations.
final class Mockify {
  /// Map to store registered methods along with their mock functions.
  final Map<Symbol, List<MockFunction>> _methods = {};

  /// Map to keep track of how many times each method is called.
  final Map<Symbol, int> _callCount = {};

  /// Map to store the arguments passed to each method during calls.
  final Map<Symbol, List<List<dynamic>>> _callArgs = {};

  /// Registers a mock function for the specified method.
  void when(Symbol method, MockFunction function) {
    _methods[method] = _methods.containsKey(method) ? [..._methods[method]!, function] : [function];
  }

  /// Calls the specified method with optional arguments and returns the result.
  FutureOr call<T>(Symbol method, [List<dynamic> args = const []]) {
    _callCount[method] = (_callCount[method] ?? 0) + 1;
    _callArgs[method] = _callArgs.containsKey(method) ? [..._callArgs[method]!, args] : [args];
    return _methods.containsKey(method) ? _methods[method]!.last(args) : throw Exception('No mock implementation for $method');
  }

  /// Verifies that a method is called a specified number of times.
  void verify(Symbol method, {required int called}) {
    final count = _callCount[method] ?? 0;
    if (count != called) {
      throw Exception('Method $method was called $count times instead of $called times.');
    }
  }

  /// Verifies that a method is never called.
  void verifyNever(Symbol method) {
    if (_callCount[method] != null && _callCount[method]! > 0) {
      throw Exception('Method $method was called ${_callCount[method]} times instead of never.');
    }
  }

  /// Verifies that a method is called with the expected arguments.
  void verifyCalledWith(Symbol method, List<dynamic> expectedArgs) {
    if (!_callArgs.containsKey(method) || !_callArgs[method]!.contains(expectedArgs)) {
      throw Exception('Method $method was not called with the expected arguments.');
    }
  }
}
