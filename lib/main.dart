import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:drexeltwo/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyDR8i_6DOSc2zsrH_IAHqu1dcsX0bdXak4',
        appId: "1:535339190665:web:dbdec58e56247ff1cdf958",
        messagingSenderId: '535339190665',
        projectId: 'drexeltwo-e5a4b',
        storageBucket: 'drexeltwo-e5a4b.appspot.com',
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const DrexelTwo());
}
