import 'package:flutter/material.dart';
import 'package:hadawi_dathboard/features/home/presentation/view/widgets/home_view_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:  TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
            child: HomeViewBody()
        ),
      ),
    );
  }
}
