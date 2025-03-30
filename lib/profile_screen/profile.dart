import 'package:didpool/change_password/change_password.dart';
import 'package:didpool/edit_profile/edit_profile.dart';
import 'package:didpool/profile_screen/provider/user_provider.dart';
import 'package:didpool/register/login.dart';
import 'package:didpool/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:didpool/components/app_text.dart';
import 'package:provider/provider.dart';
import 'widgets/profile_info_widget.dart';
import 'widgets/settings_item.dart';
import 'widgets/stats_summary_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void _handleDeleteAccount(BuildContext context) {
  // Create a function to navigate to login that doesn't depend on context
  void navigateToLogin() {
    // Use a new, fresh context from a new MaterialPageRoute
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (Route<dynamic> route) => false, // Remove all previous routes
    );
  }
  
  showDialog(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text("Delete Account", style: TextStyle(color: Colors.red)),
      content: const Text(
        "Are you sure you want to delete your account? This action is irreversible, and all your data will be lost!",
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: const Text("Cancel",style: TextStyle(color:Colors.white),),
        ),
        TextButton(
          onPressed: () async {
            // First, close the dialog
            Navigator.pop(dialogContext);
            
            // Show a loading indicator
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (loadingContext) => const Center(
                child: CircularProgressIndicator(),
              ),
            );
            
            String? userId = FirebaseService().getCurrentUser()?.uid;
            if (userId != null) {
              try {
                // Delete Firestore data first
                await FirebaseService().deleteUserData(userId);
                
                try {
                  // Try to delete Auth account
                  await FirebaseService().deleteUserAccount();
                } catch (authError) {
                  print("Auth deletion error: $authError");
                  // Continue anyway since we've deleted the user data
                }
                
                // Always sign out
                await FirebaseService().signOut();
                
                // Close any loading indicator and navigate
                Navigator.of(context).pop(); // Remove loading dialog
                navigateToLogin();
                
              } catch (e) {
                print("Error during account deletion: $e");
                // Close any loading indicator
                Navigator.of(context).pop(); // Remove loading dialog
                
                // Show error using a new dialog instead of ScaffoldMessenger
                if (context.mounted) {
                  showDialog(
                    context: context,
                    builder: (errorContext) => AlertDialog(
                      title: const Text("Error"),
                      content: const Text("Failed to delete account. Try again later."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(errorContext);
                            navigateToLogin(); // Navigate to login anyway
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  );
                } else {
                  // If context is not mounted, just navigate without showing error
                  navigateToLogin();
                }
              }
            }
          },
          child: const Text("Delete", style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );
}


  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Logout"),
        content: Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              try {
                FirebaseService().signOut();
                Navigator.pop(context);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'An Error Occured',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: Text("Logout"),
          ),
        ],
      ),
    );
  }

  final Map<String, dynamic> userStats = {
    'totalSteps': 249731,
    'avgWaterIntake': 6.5,
    'workoutsCompleted': 43,
    'streakDays': 16,
  };

  final List<Map<String, dynamic>> settingsItems = [
    {
      'title': 'Edit Profile',
      'icon': Icons.person,
      'hasNotification': false,
    },
    {
      'title': 'Change Password',
      'icon': Icons.lock,
      'hasNotification': false,
    },
    {
      'title': 'Delete Account',
      'icon': Icons.delete,
      'hasNotification': false,
    },
    {
      'title': 'Logout',
      'icon': Icons.logout_outlined,
      'hasNotification': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xff1F1926),
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        primary: true,
        backgroundColor: const Color(0xff1F1926),
        title: Text(
          'My Profile',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: const Color(0xffE9E3E4),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                ProfileInfoWidget(
                  userData: {
                    'name': userProvider.name,
                    'email': userProvider.email,
                    'profileImage': 'assets/images/profile.png',
                    'memberSince': userProvider.memberSince,
                    'profilePic': userProvider.profilePic
                  },
                ),
                SizedBox(height: 25.h),
                // AppText(
                //   'Your Stats',
                //   fontSize: 16.sp,
                //   fontWeight: FontWeight.w600,
                //   color: const Color(0xffE9E3E4),
                // ),
                // SizedBox(height: 15.h),
                // StatsSummaryCard(stats: userStats),
                // SizedBox(height: 25.h),
                AppText(
                  'Settings',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xffE9E3E4),
                ),
                SizedBox(height: 15.h),
                ...settingsItems.map((item) => SettingsItem(
                      settingData: item,
                      onTap: () {
                        if (item['title'] == 'Logout') {
                          _handleLogout(context);
                        } else if (item['title'] == 'Edit Profile') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfileScreen()));
                        } else if (item['title'] == 'Change Password') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ChangePasswordScreen()));
                        } else if (item['title'] == 'Delete Account') {
                          _handleDeleteAccount(context);
                        }
                      },
                    )),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
