import 'package:flutter/material.dart';
import 'package:trivia_clean_architecture/injection_container.dart' as di;
import 'features/number_trivia/presentation/pages/number_trivia_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clean Architecture Trivia App',
      theme: ThemeData(
        primaryColor: Colors.teal,
        secondaryHeaderColor: Colors.tealAccent,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          primary: Colors.teal,
          secondary: Colors.tealAccent,
        ),
        useMaterial3: true,
      ),
      home: const NumberTriviaPage(),
    );
  }
}
