import 'package:flutter/foundation.dart';

/// Desktop (Windows, macOS, Linux) uses a wider grid; mobile and web use 2 columns.
int productGridCrossAxisCountForPlatform() {
  switch (defaultTargetPlatform) {
    case TargetPlatform.windows:
    case TargetPlatform.macOS:
    case TargetPlatform.linux:
      return 7;
    default:
      return 2;
  }
}
