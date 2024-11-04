// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDgqcJNViZuDcT1StsRugf4mh4uWgJslDI',
    appId: '1:44728322199:web:1b139b8459f7136eeec1d2',
    messagingSenderId: '44728322199',
    projectId: 'meal-app-9baa2',
    authDomain: 'meal-app-9baa2.firebaseapp.com',
    storageBucket: 'meal-app-9baa2.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD1M2YMDGXTMzvo0EuB5ijWG14SpP-KE_Y',
    appId: '1:44728322199:android:0f0def3c2bd20dd2eec1d2',
    messagingSenderId: '44728322199',
    projectId: 'meal-app-9baa2',
    storageBucket: 'meal-app-9baa2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB_MazZBllckHskVIjLAii8fkQb_AD_Phs',
    appId: '1:44728322199:ios:48c4e6e4c33bb446eec1d2',
    messagingSenderId: '44728322199',
    projectId: 'meal-app-9baa2',
    storageBucket: 'meal-app-9baa2.appspot.com',
    iosBundleId: 'com.example.mealsFbBloc',
  );
}