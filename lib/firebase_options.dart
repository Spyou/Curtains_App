import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDyacX5F3U8P1JlEubV22qwx8Pw8J9Yk7Q',
    appId: '1:645739445640:web:4d958b2e28c8c9ccccce3d',
    messagingSenderId: '645739445640',
    projectId: 'curtains-app',
    authDomain: 'curtains-app.firebaseapp.com',
    storageBucket: 'curtains-app.appspot.com',
    measurementId: 'G-V5599YFEDC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBzrX4GkHszUoKvyLttwIDH7Y365kywYa0',
    appId: '1:645739445640:android:1b77130cbf342365ccce3d',
    messagingSenderId: '645739445640',
    projectId: 'curtains-app',
    storageBucket: 'curtains-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAsHIcV_8ysWLNpxz77GcZl12DxrTrNcsA',
    appId: '1:645739445640:ios:7b739e84f9d34ac8ccce3d',
    messagingSenderId: '645739445640',
    projectId: 'curtains-app',
    storageBucket: 'curtains-app.appspot.com',
    iosBundleId: 'com.spyou.curtainsApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAsHIcV_8ysWLNpxz77GcZl12DxrTrNcsA',
    appId: '1:645739445640:ios:a765132f4cf78532ccce3d',
    messagingSenderId: '645739445640',
    projectId: 'curtains-app',
    storageBucket: 'curtains-app.appspot.com',
    iosBundleId: 'com.spyou.curtainsApp.RunnerTests',
  );
}
