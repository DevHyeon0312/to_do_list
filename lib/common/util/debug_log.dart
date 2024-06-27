import 'package:flutter/foundation.dart';
import 'package:to_do_list/common/util/platform_util.dart';

// ignore_for_file: avoid_print

class DebugLog {
  static const packageName = 'flutter_template';
  static const isShowAllStackTrace = false;
  static void _iosLog(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    int showStackStartIndex = 2,
  }) {
    if (!kDebugMode) {
      return;
    }
    var showFilter = isShowAllStackTrace
        ? (element) => element.isNotEmpty
        : (element) =>
            element.isNotEmpty &&
            (element.contains('package:$packageName') ||
                element.contains('packages/$packageName'));

    var emoji = error != null ? '🚫' : '💡';
    print(
        '┌────────────────────────────────────────── $emoji ${DateTime.now()} $emoji ────────────────────────────────────────────');
    (stackTrace ?? StackTrace.current)
        .toString()
        .split('\n')
        .where((element) => showFilter(element))
        .toList()
        .asMap()
        .forEach((index, element) {
      element =
          element.replaceAll('packages/$packageName', 'package:$packageName');
      if (index >= showStackStartIndex) {
        print('│$element');
      }
    });
    if (error == null) {
      print(
          '├─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────');
      print('│ $message');
      print(
          '└─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────');
    } else {
      print(
          '├─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────');
      print('│ $error');
      print(
          '├─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────');
      print('│ $message');
      print(
          '└─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────');
    }
  }

  static void _defaultLog(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    String? color = '\x1B[0m',
    int showStackStartIndex = 2,
  }) {
    if (!kDebugMode) {
      return;
    }
    var showFilter = isShowAllStackTrace
        ? (element) => element.isNotEmpty
        : (element) =>
            element.isNotEmpty &&
            (element.contains('package:$packageName') ||
                element.contains('packages/$packageName'));

    var emoji = error != null ? '🚫' : '💡';
    print(
        '$color┌────────────────────────────────────────── $emoji ${DateTime.now()} $emoji ────────────────────────────────────────────\x1B[0m');
    (stackTrace ?? StackTrace.current)
        .toString()
        .split('\n')
        .where((element) => showFilter(element))
        .toList()
        .asMap()
        .forEach((index, element) {
      element =
          element.replaceAll('packages/$packageName', 'package:$packageName');
      if (index >= showStackStartIndex) {
        print('$color│$element \x1B[0m ');
      }
    });
    if (error == null) {
      print(
          '$color├─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────\x1B[0m');
      print('$color│ $message \x1B[0m');
      print(
          '$color└─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────\x1B[0m');
    } else {
      print(
          '$color├─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────\x1B[0m');
      print('$color│ $error \x1B[0m');
      print(
          '$color├─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────\x1B[0m');
      print('$color│ $message \x1B[0m');
      print(
          '$color└─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────\x1B[0m');
    }
  }

  static void d(
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (PlatformUtil.isIOS()) {
      _iosLog(message, error: error, stackTrace: stackTrace);
    } else {
      _defaultLog(message,
          error: error, stackTrace: stackTrace, color: '\x1B[37m');
    }
  }

  static void i(
    String message, {
    StackTrace? stackTrace,
  }) {
    if (PlatformUtil.isIOS()) {
      _iosLog(message, error: null, stackTrace: stackTrace);
    } else {
      _defaultLog(message,
          error: null, stackTrace: stackTrace, color: '\x1B[34m');
    }
  }

  static void e(
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (PlatformUtil.isIOS()) {
      _iosLog(message, error: error, stackTrace: stackTrace);
    } else {
      _defaultLog(message,
          error: error, stackTrace: stackTrace, color: '\x1B[31m');
    }
  }
}
