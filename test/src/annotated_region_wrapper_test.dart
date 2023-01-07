// ignore_for_file: prefer_const_constructors

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:re_widgets/re_widgets.dart';

void main() {
  group('AnnotatedRegionWrapper', () {
    test('can be instantiated', () {
      expect(const AnnotatedRegionWrapper(child: SizedBox.shrink()), isNotNull);
    });
  });
}
