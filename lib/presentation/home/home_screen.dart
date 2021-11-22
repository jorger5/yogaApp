import 'package:flutter/material.dart';

import 'package:zen_app/core/utils/string_helpers.dart';
import 'package:zen_app/data/user/repositories/user_repository.dart';
import 'package:zen_app/domain/entities/user.dart';
import 'package:zen_app/presentation/home/widgets/user_info_cards.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserRepository? _userRepository = UserRepository();

  @override
  void initState() {
    _userRepository?.getUser(id: 'NypHBBeF97r0HWKqd1vp');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: NetworkImage('https://wallpaperaccess.com/full/1630259.jpg'),
        fit: BoxFit.cover,
      )),
      padding: EdgeInsets.only(top: size.height * 0.1, left: size.width * 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              StreamBuilder<User>(
                  stream: _userRepository?.user,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        '${StringHelpers.greeting()}, ${snapshot.data?.name}',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      );
                    } else {
                      return Text(
                        'Good day!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }
                  }),
              Expanded(child: SizedBox()),
              IconButton(
                onPressed: () => print('Notification screen pressed'),
                icon: Icon(Icons.notifications_none_outlined),
              ),
              SizedBox(
                width: size.width * 0.1,
              )
            ],
          ),
          Row(
            children: [
              Column(
                children: const [
                  UserInfoCards(icon: Icons.calendar_today, info: '10 days'),
                  UserInfoCards(icon: Icons.lock_clock, info: '30 min'),
                  UserInfoCards(icon: Icons.fitness_center, info: '400 kCal')
                ],
              ),
              Image(
                height: size.height * (0.2),
                image: AssetImage('assets/images/standing_bow_pose.png'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
