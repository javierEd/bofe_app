import 'package:flutter/material.dart';

import '../components/screen_title.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTitle(
      title: 'Home',
      child: Scaffold(appBar: AppBar(), body: SizedBox()),
    );
  }
}
