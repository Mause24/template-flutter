import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  final String? title;
  final Widget child;

  const MainLayout({super.key, this.title, required this.child});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  /* int _currentIndex = 1;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (context.mounted) {
      context.go(PrivateRoutes.home);
      switch (index) {
        case 0:
          context.go(PrivateRoutes.reports);
          break;
        case 1:
          context.go(PrivateRoutes.home);
          break;
        case 2:
          context.go(PrivateRoutes.inventory);
          break;
      }
    }
  } */

  @override
  Widget build(BuildContext context) {
    final currentTitle = widget.title;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: currentTitle != null ? Text(currentTitle) : null,
      ),
      body: SafeArea(child: widget.child),
      /* bottomNavigationBar: BottomTabs(
        currentIndex: _currentIndex,
        onTapBottomItem: _onTabTapped,
        items: const [
          TabData(icon: Icons.home_rounded, label: 'Inicio'),
        ],
        style: BottomTabsStyle(
          activeCircleColor: Colors.white,
          activeIconColor: AppColors.primaryLight,
          barColor: AppColors.primaryLight,
          inactiveIconColor: Colors.white,
        ),
      ), */
    );
  }
}
