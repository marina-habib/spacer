import 'package:flutter/material.dart';
import 'package:spacer/core/UI/Screens/HomeScreen/home_screen.dart';
import 'package:spacer/core/UI/Screens/LoginScreen/login_screen.dart';
import 'package:spacer/core/UI/Screens/PlanetScreen/planet_screen.dart';
import 'package:spacer/core/thems/app_colors.dart';

void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     theme: ThemeData(scaffoldBackgroundColor: AppColors.black),
        color: AppColors.black,
        debugShowCheckedModeBanner: false,
        initialRoute:LoginScreen.routeName ,
       routes: {
          LoginScreen.routeName:(context)=>const LoginScreen(),
          HomeScreen.routeName:(context)=>const HomeScreen(),
          PlanetScreen.routeName:(context)=> const PlanetScreen()
       },
    );
  }
}
