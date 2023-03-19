import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:steam_project/resources/resources.dart';

void main() {
  test('vectorial_images assets test', () {
    expect(File(VectorialImages.back).existsSync(), true);
    expect(File(VectorialImages.close).existsSync(), true);
    expect(File(VectorialImages.emptyLikes).existsSync(), true);
    expect(File(VectorialImages.emptyWhishlist).existsSync(), true);
    expect(File(VectorialImages.like).existsSync(), true);
    expect(File(VectorialImages.likeFull).existsSync(), true);
    expect(File(VectorialImages.power).existsSync(), true);
    expect(File(VectorialImages.search).existsSync(), true);
    expect(File(VectorialImages.search1).existsSync(), true);
    expect(File(VectorialImages.warning).existsSync(), true);
    expect(File(VectorialImages.whishlist).existsSync(), true);
    expect(File(VectorialImages.whishlistFull).existsSync(), true);
  });
}
