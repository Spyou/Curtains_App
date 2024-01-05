import 'package:curtains_app/blocs/add_bloc/add_bloc.dart';
import 'package:curtains_app/blocs/home_bloc/home_bloc.dart';
import 'package:curtains_app/core/db/myDb.dart';
import 'package:curtains_app/firebase_options.dart';
import 'package:curtains_app/screens/home/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(),
        ),
        BlocProvider<AddBloc>(
          create: (context) => AddBloc(myDb: MyDb()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(useMaterial3: true,

          visualDensity: VisualDensity.adaptivePlatformDensity,),

        home: const HomePage(),
      ),
    );
  }
}
