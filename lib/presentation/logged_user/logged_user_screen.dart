import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zen_app/application/ui/ui_cubit.dart';
import 'package:zen_app/presentation/home/home_screen.dart';
import 'package:zen_app/presentation/logged_user/widgets/logged_user_bottom_bar.dart';
import 'package:zen_app/presentation/profile/profile_screen.dart';

class LoggedUserScreen extends StatefulWidget {
  const LoggedUserScreen({Key? key}) : super(key: key);

  @override
  _LoggedUserScreenState createState() => _LoggedUserScreenState();
}

class _LoggedUserScreenState extends State<LoggedUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UiCubit, UiState>(
        builder: (context, state) {
          if (state is HomeScreenSelected) {
            return HomeScreen();
          } else if (state is YogaScreenSelected) {
            return Text('yoga');
          } else if (state is MeditationScreenSelected) {
            return Text('meditation');
          } else if (state is ProfileScreenSelected) {
            return ProfileScreen();
          } else {
            return HomeScreen();
          }
        },
      ),
      bottomNavigationBar: LoggedUserBottomBar(),
    );
  }
}
