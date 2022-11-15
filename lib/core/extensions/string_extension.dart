import '../../main.dart';

extension StringExtension on String? {
  String getType() {
    if (this == null) return 'Searching';
    if (ups.hasMatch(this!)) return 'UPS';
    if (dpd.hasMatch(this!)) return 'dpd';
    if (royalMail.hasMatch(this!)) return 'royalMail';
    if (amazonLogistics.hasMatch(this!)) return 'amazonLogistics';
    return 'Still Searching';
  }

  String getCode() {
    String finalResult = '';
    int startIndex = 0;
    if (this == null) return 'Still Searching';
    if (getType() == 'dpd') {
      for (int i = 0; i < this!.length; i++) {
        if (this![i] == '1' &&
            this![i + 1] == '5' &&
            this![i + 2] == '5' &&
            this![i + 3] == '0') {
          startIndex = i + 4;
          finalResult += '1550';
          break;
        }
      }
      int counter = 0;
      while (counter <= 8) {
        finalResult += this![startIndex + counter];
        counter++;
      }

      return finalResult;
    }
    return this!;
  }
}
