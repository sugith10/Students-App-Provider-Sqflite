import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_10/controller/controller.dart';
import 'package:sqflite_10/provider/home_screen.dart';
import 'package:sqflite_10/screen/home_screen/homescreen.dart';
import 'package:sqflite_10/screen/searchscreen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final databaseProvider = DatabaseProvider();
  await databaseProvider.initializeDatabase();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<DatabaseProvider>.value(value: databaseProvider),
        ChangeNotifierProvider<HomeScreenProvider>(
          create: (context) => HomeScreenProvider(),
        ),
        ChangeNotifierProvider<SearchProvider>(create: (context)=> SearchProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Students App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 89, 55, 32),
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreeen(),
    );
  }
}
