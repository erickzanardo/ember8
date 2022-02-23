// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:auth_repository/auth_repository.dart';

void main() {
  group('AuthRepository', () {
    test('can be instantiated', () {
      expect(AuthRepository(), isNotNull);
    });
  });
}
