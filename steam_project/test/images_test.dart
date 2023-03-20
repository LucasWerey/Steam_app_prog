import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:steam_project/resources/resources.dart';

void main() {
  test('images assets test', () {
    expect(File(Images.backgroundEmpty).existsSync(), true);
    expect(File(Images.backgroundImg).existsSync(), true);
    expect(File(Images.hero).existsSync(), true);
    expect(File(Images.steam).existsSync(), true);
  });
}
