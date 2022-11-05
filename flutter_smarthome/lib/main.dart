import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_smarthome/model/auth/main_page_auth.dart';
import 'package:flutter_smarthome/view_model/switch_provider.dart';
import 'package:provider/provider.dart';
import 'firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorSchemeSeed: const Color(0xff6750a4), useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
        create: (context) => SwitchProvider(),
        child: const Main(),
      ),
    );
  }
}
