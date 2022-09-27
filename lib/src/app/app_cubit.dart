import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AppState {
  const AppState();
}

class LoadingState extends AppState {
  const LoadingState();
}

class HomePageState extends AppState {
  const HomePageState();
}

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const LoadingState()) {
    _init();
  }

  Future<void> _init() async {
    emit(const LoadingState());
    emit(const HomePageState());
  }
}
