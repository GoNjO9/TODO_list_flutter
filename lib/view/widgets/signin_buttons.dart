import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
            child: const Text('Login'),
          );
        } else {
          return ElevatedButton(
            onPressed: () => {userVM.signOut()},
            child: const Text('Logout'),
          );
        }
      },
    );
  }
}
