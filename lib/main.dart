import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:studentapp_provider/model/modal.dart';
import 'package:studentapp_provider/provider/dailog_screen/dialog_screen.dart';
import 'package:studentapp_provider/provider/database.dart';
import 'package:studentapp_provider/provider/image_function/image_function.dart';
import 'package:studentapp_provider/screens/home/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => StudentImage(),
        ),
        ChangeNotifierProvider(
          create: (context) => StudentData(),
        ),
        ChangeNotifierProvider(
          create: (context) => DailogProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
