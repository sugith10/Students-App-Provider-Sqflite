import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studnets_app/controller/controller.dart';
import 'package:studnets_app/presentation/screen/add_screen/addstudent.dart';
import 'package:studnets_app/provider/add_screen.dart';
import 'package:studnets_app/provider/home_screen.dart';
import 'package:studnets_app/presentation/screen/search_screen/searchscreen.dart';
import 'package:studnets_app/presentation/screen/splash_page/splash_page.dart';


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
        ChangeNotifierProvider<SearchProvider>(
            create: (context) => SearchProvider()),
            ChangeNotifierProvider<AddPageProvider>(
      create: (context) => AddPageProvider()),
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
          seedColor: const Color.fromARGB(255, 255, 255, 255),
        ),
        useMaterial3: true,
        fontFamily: 'poppins',
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
    );
  }
}
