import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/config/routes.dart';
import 'package:news_app_clean_architecture/config/themes.dart';
import 'package:news_app_clean_architecture/injection_container.dart';
import 'package:news_app_clean_architecture/simple_bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await injectionContainer();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      navigatorKey: navKey,
      theme: appTheme,
      onGenerateRoute: AppRoute.onGenerateRoute,
    );
  }
}
