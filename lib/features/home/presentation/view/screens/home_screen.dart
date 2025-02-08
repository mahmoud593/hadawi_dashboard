import 'package:flutter/material.dart';
import 'package:hadawi_dathboard/features/home/presentation/view/widgets/home_view_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: HomeViewBody(),
    );
  }
}
