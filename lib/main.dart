import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_g9/firebase_options.dart';
import 'package:todo_list_g9/view/my_home_page.dart';
import 'package:todo_list_g9/view_model/event_view_model.dart';
import 'package:todo_list_g9/view_model/user_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProxyProvider<UserViewModel, EventViewModel>(
          create: (context) => EventViewModel(context.read()),
          update: (context, value, previous) => EventViewModel(value),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false, //去掉紅色酷debug
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 248, 255, 106)),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'TODO list'),
      ),
    );
  }
}
