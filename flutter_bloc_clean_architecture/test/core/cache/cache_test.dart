import 'package:flutter_bloc_clean_architecture/infrastructure/cache/cache.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('$CacheClient', () {
    test('should read value if written', () {
      final cache = CacheClient()..write(key: '1', value: 'a');
      expect(cache.read(key: '1'), 'a');
    });

    test('should not read value if written but deleted', () {
      final cache = CacheClient()
        ..write(key: '1', value: 'a')
        ..remove(key: '1');
      expect(cache.read(key: '1'), null);
    });
  });
}
