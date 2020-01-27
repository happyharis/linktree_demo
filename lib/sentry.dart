import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:linktree_demo_clone/linktree.dart';
import 'package:sentry/sentry.dart';

final SentryClient sentry = SentryClient(
  dsn: "your-dsn-key",
);

class SentryExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ButtonLink(
            text: 'Dart Exception',
            onPressed: () async => await throwDartException(),
          ),
          ButtonLink(
            text: 'Async Dart Exception',
            onPressed: () async => await throwAsyncDartException(),
          ),
          ButtonLink(
            text: '3rd Party Exception',
            onPressed: () async => await throwPluginException(),
          ),
        ],
      ),
    );
  }

  Future throwPluginException() async {
    try {
      final channel = const MethodChannel('crashy-custom-channel');
      await channel.invokeMethod('blah');
    } catch (error, stackTrace) {
      if (isInDebugMode) {
        print(error);
        await sentry.captureException(
          exception: error,
          stackTrace: stackTrace,
        );
      }
    }
  }

  Future throwAsyncDartException() async {
    try {
      foo() async {
        throw new StateError('This is an async Dart exception.');
      }

      bar() async {
        await foo();
      }

      await bar();
    } catch (error, stackTrace) {
      if (isInDebugMode) {
        print(error);
        await sentry.captureException(
          exception: error,
          stackTrace: stackTrace,
        );
      }
    }
  }

  Future throwDartException() async {
    try {
      throw new StateError('This is a Dart exception.');
    } catch (error, stackTrace) {
      if (isInDebugMode) {
        print(error);
        await sentry.captureException(
          exception: error,
          stackTrace: stackTrace,
        );
      }
    }
  }
}

bool get isInDebugMode {
  // Assume you're in production mode.
  bool inDebugMode = false;

  // Assert expressions are only evaluated during development. They are ignored
  // in production. Therefore, this code only sets `inDebugMode` to true
  // in a development environment.
  assert(inDebugMode = true);
  print('Debug mode: $inDebugMode');
  return inDebugMode;
}
