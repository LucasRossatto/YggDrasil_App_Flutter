import 'package:flutter/material.dart';
import 'package:yggdrasil_app/src/view/widgets/home_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required Type usuario});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          HomeHeader(usuario: 'Usuar',)
        ],
      ),
    );
  }
}