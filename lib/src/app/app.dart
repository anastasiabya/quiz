import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_cubit.dart';

import '../presenter/quiz_choice/quiz_choice_page.dart';
import '../presenter/splash/splash_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppCubit(),
      child: const AppWidget(),
    );
  }
}

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 180, 223, 255)),
      debugShowCheckedModeBanner: false,
      home: _homeWidget(),
    );
  }

  Widget _homeWidget() {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        if (state is HomePageState) {
          return const QuizChoicePage();
        }
        return const SplashScreen();
      },
    );
  }
}
