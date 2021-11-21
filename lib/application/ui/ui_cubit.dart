import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'ui_state.dart';

class UiCubit extends Cubit<UiState> {
  UiCubit() : super(const UiState());

  void animationCompleted(bool value) {
    emit(state.copyWith(
      animationCompleted: value,
    ));
  }

  Future<void> selectedScreen(String screen) async {
    final String newScreen = screen;

    emit(state.copyWith(
      selectedScreen: newScreen,
    ));

    try {
      switch (screen) {
        case 'home':
          emit(const HomeScreenSelected());
          break;
        case 'yoga':
          emit(const YogaScreenSelected());
          break;
        case 'meditation':
          emit(const MeditationScreenSelected());
          break;
        case 'profile':
          emit(const ProfileScreenSelected());
          break;
        default:
      }
    } catch (e) {
      print(e);
    }
  }
}
