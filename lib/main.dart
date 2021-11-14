import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zen_app/application/auth/auth_cubits/auth_cubit.dart';
import 'package:zen_app/application/auth/login_cubits/login_cubit.dart';
import 'package:zen_app/application/ui/ui_cubit.dart';
import 'package:zen_app/config/routes/routes.dart';
import 'package:zen_app/infrastructure/auth/repositories/authentication_repository.dart';
import 'package:zen_app/presentation/app_bloc_observer.dart';
import 'package:zen_app/presentation/logged_user/logged_user_screen.dart';
import 'package:zen_app/presentation/login/login_screen.dart';

Future<void> main() async {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    runApp(App());
  } catch (e) {
    print(e);
  }
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  @override
  void initState() {
    super.initState();
    LoginCubit(_authenticationRepository);
    AuthCubit(_authenticationRepository);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(_authenticationRepository),
        ),
        BlocProvider(
          create: (context) => AuthCubit(_authenticationRepository),
        ),
        BlocProvider(create: (context) => UiCubit()),
      ],
      child: MaterialApp(
        home: BlocProvider(
          create: (context) => AuthCubit(_authenticationRepository),
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is Unauthenticated) {
                return LoginScreen();
              }
              if (state is Authenticated) {
                return LoggedUserScreen();
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
        title: 'Yoga App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: GoogleFonts.roboto().fontFamily,
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: PageRoutes.routes,
      ),
    );
  }
}
