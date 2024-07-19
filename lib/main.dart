import 'package:flutter/material.dart';
import 'package:trivia_clean_architecture/injection_container.dart' as di;
import 'features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  ErrorWidget.builder = (FlutterErrorDetails details) => const Scaffold(
        body: Center(
          child: Text('Something went wrong!',
              style: TextStyle(color: Colors.red)),
        ),
      );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clean Architecture Trivia App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
        ),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English
        // Add other locales your app supports
      ],
      home: const NumberTriviaPage(),
    );
  }
}
