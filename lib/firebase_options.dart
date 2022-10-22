// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyBr9pA-CIhy_g3chfA1PwtRqQj2H7KCkNQ',
    appId: '1:1044293794222:web:c012c9aa48178d1455703f',
    messagingSenderId: '1044293794222',
    projectId: 'pro-courseapp-023',
    authDomain: 'pro-courseapp-023.firebaseapp.com',
    storageBucket: 'pro-courseapp-023.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDW0nwIZcm2WleUXT4Jq5C0ClWb5hs_Q7s',
    appId: '1:1044293794222:android:92b8dbece839073855703f',
    messagingSenderId: '1044293794222',
    projectId: 'pro-courseapp-023',
    storageBucket: 'pro-courseapp-023.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCZsJtc0TUjwHLWVEDB8a0VbqMV7WlthXA',
    appId: '1:1044293794222:ios:0d4d3fb3c29c3f9f55703f',
    messagingSenderId: '1044293794222',
    projectId: 'pro-courseapp-023',
    storageBucket: 'pro-courseapp-023.appspot.com',
    iosClientId: '1044293794222-cshmdmu63b262q14im1h4pbb61ds05rt.apps.googleusercontent.com',
    iosBundleId: 'com.example.proCourseApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCZsJtc0TUjwHLWVEDB8a0VbqMV7WlthXA',
    appId: '1:1044293794222:ios:0d4d3fb3c29c3f9f55703f',
    messagingSenderId: '1044293794222',
    projectId: 'pro-courseapp-023',
    storageBucket: 'pro-courseapp-023.appspot.com',
    iosClientId: '1044293794222-cshmdmu63b262q14im1h4pbb61ds05rt.apps.googleusercontent.com',
    iosBundleId: 'com.example.proCourseApp',
  );
}
