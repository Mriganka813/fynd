import 'package:flutter/material.dart';
import 'package:gofoods/screens/onbonding/onbonding.dart';
import 'package:provider/provider.dart';

import 'utils/notifirecolor.dart';

void main() {
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
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Onbonding(),
      ),
    );
  }
}
