import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../inbox/presentation/screens/inbox_screen.dart';
import '../controllers/nav_bar_cubit/nav_bar_cubit.dart';
import '../widgets/nav_bar_body.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

class NavBarScreen extends StatelessWidget {
  const NavBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: context.read<NavBarCubit>().pageController,
        children: const [
          HomeScreen(),
          InboxScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: const NavBarBody(),
    );
  }
}
