import 'package:flutter/material.dart';

import 'feature/home/view/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final _appTitle = "Orkay Academy";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      title: _appTitle,
      home: const HomeView(),
    );
  }
}


/*
class HomeBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    'Bloc $bloc'.log();
    super.onTransition(bloc, transition);
  }

  @override
  void onCreate(BlocBase bloc) {
    'Home Bloc Created'.log();
    super.onCreate(bloc);
  }
}

extension Log on Object {
  void log() => devtools.log(toString());
}
*/