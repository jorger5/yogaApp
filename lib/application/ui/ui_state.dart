part of 'ui_cubit.dart';

class UiState extends Equatable {
  const UiState({
    this.animationCompleted = false,
    this.selectedScreen = 'home',
  });

  final bool animationCompleted;
  final String selectedScreen;

  @override
  List<dynamic> get props => [animationCompleted];

  UiState copyWith({
    bool? animationCompleted,
    String? selectedScreen,
  }) {
    return UiState(
      animationCompleted: animationCompleted ?? this.animationCompleted,
      selectedScreen: selectedScreen ?? this.selectedScreen,
    );
  }
}

class HomeScreenSelected extends UiState {
  const HomeScreenSelected();
}

class YogaScreenSelected extends UiState {
  const YogaScreenSelected();
}

class MeditationScreenSelected extends UiState {
  const MeditationScreenSelected();
}

class ProfileScreenSelected extends UiState {
  const ProfileScreenSelected();
}
