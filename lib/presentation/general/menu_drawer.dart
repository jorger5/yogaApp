import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zen_app/application/auth/auth_cubits/auth_cubit.dart';
import 'package:zen_app/data/user/models/user_model.dart';
import 'package:zen_app/core/utils/constants.dart';
import 'package:zen_app/presentation/login/login_screen.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({Key? key, this.user});
  final UserModel? user;
  @override
  _MenuDrawerState createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  AuthCubit? _authCubit;

  @override
  void initState() {
    _authCubit = BlocProvider.of<AuthCubit>(context);

    super.initState();
  }

  void logout() {
    _authCubit?.userLogOut();
  }

  Widget drawHeader(Size size) {
    return Container(
        height: size.height * 0.15,
        child: DrawerHeader(
          child: Row(
            children: [
              CircleAvatar(
                radius: size.height * 0.03,
                backgroundColor: Colors.grey,
                child: CircleAvatar(
                  radius: size.height * 0.028,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: size.width * 0.04),
                width: size.width * 0.50,
                child: Text(
                  'Hello ${widget.user?.name ?? widget.user?.email}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: size.height * 0.02,
                  ),
                ),
              ),
              Expanded(child: SizedBox()),
              IconButton(
                  icon: Icon(
                    Icons.article,
                    color: Colors.blue,
                  ),
                  onPressed: () => Navigator.pushNamed(context, homeRoute))
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Container(
        width: size.width * 0.9,
        child: ClipRRect(
          borderRadius: BorderRadius.horizontal(right: Radius.circular(15)),
          child: Drawer(
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is Unauthenticated) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute<void>(
                        builder: (BuildContext context) => const LoginScreen()),
                    ModalRoute.withName(loginRoute),
                  );
                }
              },
              builder: (context, state) {
                return ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    Container(
                      height: size.height * 0.25,
                      child: Column(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              color: Colors.green,
                            ),
                          ),
                          Flexible(
                            flex: 6,
                            child: drawHeader(size),
                          )
                        ],
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.language,
                        color: Colors.green,
                      ),
                      title: const Text('Page 1'),
                      onTap: () => print('To page 1'),
                    ),
                    ListTile(
                        leading: Icon(
                          Icons.policy,
                          color: Colors.green,
                        ),
                        title: const Text('Page 2'),
                        onTap: () => print('To page 2')),
                    ListTile(
                        leading: Icon(
                          Icons.logout,
                          color: Colors.green,
                        ),
                        title: const Text('Cerrar sesión'),
                        onTap: () => logout()),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
