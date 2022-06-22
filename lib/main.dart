import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gofoods/screens/splashscreen.dart';
import 'package:gofoods/utils/global.dart';
import 'package:gofoods/utils/locator.dart';
import 'package:provider/provider.dart';

import 'utils/notifirecolor.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  locator.registerLazySingleton(() => GlobalServices());
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ColorNotifier(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        navigatorKey: locator<GlobalServices>().navigatorKey,
        // home: Onbonding(),
        // home: PhoneNumber(),
        home: SplashScreen(),
      ),
    );
  }
}
