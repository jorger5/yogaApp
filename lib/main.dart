import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:zen_app/application/auth/auth_cubits/auth_cubit.dart';
import 'package:zen_app/config/injectable/injector.dart';
import 'package:zen_app/config/routes/routes.dart';
import 'package:zen_app/data/auth/repositories/authentication_repository_impl.dart';
import 'package:zen_app/presentation/logged_user/logged_user_screen.dart';
import 'package:zen_app/presentation/login/login_screen.dart';

Future<void> main() async {
  // Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    await configureDependencies();
    runApp(App());
  } catch (e) {
    print(e);
  }
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final AuthenticationRepositoryImpl _authenticationRepository =
      AuthenticationRepositoryImpl();

  @override
  void initState() {
    super.initState();

    AuthCubit(_authenticationRepository);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(_authenticationRepository),
        ),
      ],
      child: MaterialApp(
        home: BlocProvider(
          create: (context) => AuthCubit(_authenticationRepository),
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is Unauthenticated) {
                return const LoginScreen();
              }
              if (state is Authenticated) {
                return const LoggedUserScreen();
              } else {
                return const CircularProgressIndicator();
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
