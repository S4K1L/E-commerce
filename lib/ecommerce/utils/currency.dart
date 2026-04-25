class Currency {
  Currency._();

  static const String symbol = '৳';

  static String format(num amount, {bool withSymbol = true, int decimals = 0}) {
    final fixed = amount.toStringAsFixed(decimals);
    final parts = fixed.split('.');
    final intPart = parts[0];
    final decPart = parts.length > 1 ? '.${parts[1]}' : '';

    final negative = intPart.startsWith('-');
    final digits = negative ? intPart.substring(1) : intPart;

    final buf = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i != 0 && (digits.length - i) % 3 == 0) buf.write(',');
      buf.write(digits[i]);
    }

    final result = '${negative ? '-' : ''}${buf.toString()}$decPart';
    return withSymbol ? '$symbol $result' : result;
  }
}
