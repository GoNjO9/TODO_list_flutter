import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_g9/view/widgets/custom_text.dart';
import 'package:todo_list_g9/view_model/user_view_model.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (context, userVM, child) {
        if (userVM.user == null) {
          return ElevatedButton(
            onPressed: () => {userVM.signInWithGoogle()},
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                Color.fromARGB(255, 111, 111, 111),
              ),
              iconColor:
                  MaterialStatePropertyAll(Color.fromARGB(100, 100, 41, 1)),
            ),
            child: const SizedBox(
              width: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.login,
                    color: Colors.white,
                  ),
                  Gap(10),
                  CustomText(
                    text: 'Login',
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
          );
        } else {
          return ElevatedButton(
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                Color.fromARGB(255, 111, 111, 111),
              ),
            ),
            onPressed: () => {userVM.signOut()},
            child: const Row(
              children: [
                Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                Gap(10),
                CustomText(
                  text: 'Logout',
                  textColor: Colors.white,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
