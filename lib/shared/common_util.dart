import 'dart:math';

import 'dart:ui';

class CommonUtil {
  static final _random = Random();
  static randomColor({double opacity = 0.2}) =>
      Color(_random.nextInt(0xffffff).toInt()).withOpacity(opacity);
}
