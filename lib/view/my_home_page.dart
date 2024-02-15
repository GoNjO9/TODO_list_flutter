import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gap/gap.dart';
import 'package:todo_list_g9/view/widgets/event_adding_button.dart';
import 'package:todo_list_g9/view/widgets/event_tiles.dart';
import 'package:todo_list_g9/view/widgets/signin_buttons.dart';
import 'package:todo_list_g9/view_model/user_view_model.dart';

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    if (context.watch<UserViewModel>().user != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(221, 255, 223, 118),
          title: Text(title),
          actions: const <Widget>[
            SignInButton(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.date_range_rounded),
            ),
          ],
        ),
        body: const EventTiles(),
        floatingActionButton: const EventAddingButton(),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(221, 255, 223, 118),
          title: Text(title),
          actions: const <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.date_range_rounded),
            ),
          ],
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login with your google account',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Gap(10),
              SignInButton(),
            ],
          ),
        ),
      );
    }
  }
}
