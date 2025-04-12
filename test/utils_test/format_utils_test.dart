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

  group('getFileExtensionFromContentType', () {
    test('returns correct extension for PDF', () {
      expect(getFileExtensionFromContentType('application/pdf'), '.pdf');
    });

    test('returns correct extension for XLSX', () {
      expect(getFileExtensionFromContentType('application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'), '.xlsx');
    });

    test('returns correct extension for XLS', () {
      expect(getFileExtensionFromContentType('application/vnd.ms-excel'), '.xls');
    });

    test('returns correct extension for JPEG image', () {
      expect(getFileExtensionFromContentType('image/jpeg'), '.jpg');
    });

    test('returns correct extension for PNG image', () {
      expect(getFileExtensionFromContentType('image/png'), '.png');
    });

    test('returns correct extension for plain text', () {
      expect(getFileExtensionFromContentType('text/plain'), '.txt');
    });

    test('returns .bin for unknown type', () {
      expect(getFileExtensionFromContentType('application/unknown'), '.bin');
    });

    test('returns .bin for null input', () {
      expect(getFileExtensionFromContentType(null), '.bin');
    });
  });

}
