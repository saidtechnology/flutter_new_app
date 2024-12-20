import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:news_app/screens/home_screen.dart';
import 'screens/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utilities/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final prefs = await SharedPreferences.getInstance();
  final bool seen = prefs.getBool('seen') ?? false;
  
  runApp(MyApp(initialScreen: seen ? const HomeScreen() : const OnBoarding()));
}

class MyApp extends StatelessWidget {
  final Widget initialScreen;

  const MyApp({
    Key? key,
    required this.initialScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('ar', ''),
      ],
      home: initialScreen,
    );
  }
}
