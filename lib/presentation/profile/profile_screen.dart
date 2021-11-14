import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zen_app/application/auth/auth_cubits/auth_cubit.dart';
import 'package:zen_app/core/models/user.dart';
import 'package:zen_app/core/utils/constants.dart';
import 'package:zen_app/infrastructure/auth/repositories/authentication_repository.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthenticationRepository? _authenticationRepository =
        AuthenticationRepository();
    final Size size = MediaQuery.of(context).size;

    final AuthCubit? _authCubit = BlocProvider.of<AuthCubit>(context);

    void logout() {
      _authCubit?.userLogOut();
    }

    return Column(
      children: [
        SizedBox(
          height: size.height * 0.1,
        ),
        Padding(
          padding: EdgeInsets.only(
              left: size.width * 0.05, right: size.width * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Profile',
                  style: TextStyle(
                    fontSize: size.height * 0.03,
                    fontWeight: FontWeight.bold,
                  )),
              Container(
                child: ElevatedButton(
                  onPressed: () => print('Settings pressed'),
                  child: Container(
                    width: size.width * 0.1,
                    alignment: Alignment.center,
                    child: Icon(
                      FontAwesomeIcons.cog,
                      color: Colors.white,
                      size: size.width * 0.05,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(), primary: blackColor),
                ),
              ),
            ],
          ),
        ),
        StreamBuilder<User>(
            stream: _authenticationRepository?.user,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      radius: size.width * 0.155,
                      backgroundColor: blackColor,
                      child: CircleAvatar(
                          radius: size.width * 0.15,
                          backgroundImage: NetworkImage(snapshot.data!.photo)),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(snapshot.data?.name ?? 'No name'),
                        SizedBox(
                          height: size.height * 0.025,
                        ),
                        Row(
                          children: const [
                            Text('Meditations here'),
                            Text('Yogas here'),
                          ],
                        ),
                        SizedBox(height: size.height * 0.1),
                      ],
                    )
                  ],
                );
              } else {
                return CircularProgressIndicator();
              }
            }),
        GestureDetector(
          child: Text(
            'Logout',
            style: TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
          onTap: logout,
        )
      ],
    );
  }
}
