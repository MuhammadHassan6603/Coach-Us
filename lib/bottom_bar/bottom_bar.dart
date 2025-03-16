import 'package:didpool/Home/meal_planner.dart';
import 'package:didpool/home/home_screen.dart';
import 'package:didpool/profile_screen/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomBarScreen extends StatefulWidget {
  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    // HomeScreen(),
    // ActivityScreen(),
    // CameraScreen(),
    MealPlanner(),
    Placeholder(),
    Placeholder(),
    Profile(),
  ];

  final List<String> _icons = [
    'assets/icons/home.svg',
    'assets/icons/activity.svg',
    'assets/icons/camera.svg',
    'assets/icons/profile.svg',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF22242E),
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 25),
        decoration: BoxDecoration(
          color: Color(0xFF22242E),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 5, spreadRadius: 1)
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_icons.length, (index) {
            bool isSelected = _selectedIndex == index;
            return GestureDetector(
              onTap: () => _onItemTapped(index),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: isSelected
                            ? [Color(0xFF983BCB), Color(0xFF4023D7)]
                            : [Colors.white, Colors.white],
                      ).createShader(bounds);
                    },
                    child: SvgPicture.asset(
                      _icons[index],
                      width: 28,
                      height: 28,
                      colorFilter: ColorFilter.mode(
                          isSelected ? Colors.white : Colors.grey,
                          BlendMode.srcIn),
                    ),
                  ),
                  SizedBox(height: 5),
                  if (isSelected)
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Color(0xFF983BCB), Color(0xFF4023D7)],
                        ),
                      ),
                    ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}