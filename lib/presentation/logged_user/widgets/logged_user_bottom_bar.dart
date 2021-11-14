import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zen_app/application/ui/ui_cubit.dart';
import 'package:zen_app/core/utils/constants.dart';

class LoggedUserBottomBar extends StatefulWidget {
  const LoggedUserBottomBar({Key? key}) : super(key: key);

  @override
  _LoggedUserBottomBarState createState() => _LoggedUserBottomBarState();
}

class _LoggedUserBottomBarState extends State<LoggedUserBottomBar> {
  UiCubit? _uiBloc;
  int _selectedScreen = 0;

  @override
  void initState() {
    _uiBloc = BlocProvider.of<UiCubit>(context);

    super.initState();
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        _uiBloc?.selectedScreen('home');
        break;
      case 1:
        _uiBloc?.selectedScreen('yoga');
        break;
      case 2:
        _uiBloc?.selectedScreen('meditation');
        break;
      case 3:
        _uiBloc?.selectedScreen('profile');
        break;
      default:
        _uiBloc?.selectedScreen('home');
    }
    setState(() => _selectedScreen = index);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.self_improvement),
          label: 'Yoga',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.spa),
          label: 'Meditation',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.userAlt),
          label: 'Profile',
        ),
      ],
      currentIndex: _selectedScreen,
      selectedItemColor: redColor,
      unselectedItemColor: blackColor,
      onTap: _onItemTapped,
    );
  }
}
