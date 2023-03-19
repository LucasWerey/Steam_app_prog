import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:steam_project/resources/resources.dart';

void main() {
  test('gif assets test', () {
    expect(File(Gif.loader).existsSync(), true);
  });
}
