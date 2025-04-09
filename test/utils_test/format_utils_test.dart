import 'package:chatting/core/data/utils/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group('formatIntSizeToStringFormat', () {

    test('returns "0 B" for 0 bytes', () {
      expect(convertSizeToString(0), equals("0 B"));
    });

    test('formats small sizes correctly', () {
      expect(convertSizeToString(150), equals("150.0 B"));
    });

    test('formats KB correctly', () {
      expect(convertSizeToString(1024), equals("1.0 KB"));
    });

    test('formats MB correctly', () {
      expect(convertSizeToString(1048576), equals("1.0 MB"));
    });

    test('formats with custom decimal places', () {
      expect(convertSizeToString(1048576, decimals: 0), equals("1 MB"));
    });
  }
  );

}
