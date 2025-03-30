import 'package:didpool/home/home_screen.dart';
import 'package:didpool/my_workouts/my_workouts.dart';
import 'package:didpool/meal_suggesstion/meal_suggesstion.dart';
import 'package:didpool/profile_screen/profile.dart';
import 'package:didpool/profile_screen/provider/user_provider.dart';
import 'package:didpool/services/workout_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  final WorkoutService _workoutService = WorkoutService();
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    MyWorkoutsScreen(),
    MealSuggestionTracker(),
    ProfileScreen(),
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
  void initState() {
    super.initState();
    // _resetStats();
    WorkoutService().createInitialUserStats();
    Provider.of<UserProvider>(context, listen: false).fetchUserData();
  }

  Future<void> _resetStats() async {
    final currentUserId = _workoutService.currentUserId;
    if (currentUserId != null) {
      await _workoutService.resetUserStats(currentUserId);
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF22242E),
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
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
                      height: index==2?35:28,
                      colorFilter: ColorFilter.mode(
                          isSelected ? Colors.white : Colors.grey,
                          BlendMode.srcIn),
                    ),
                  ),
                  index==2?SizedBox(height: 8,):SizedBox.shrink()
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}