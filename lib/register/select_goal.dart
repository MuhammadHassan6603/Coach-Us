// import 'package:didpool/components/app_text.dart';
// import 'package:didpool/components/custom_button.dart';
// import 'package:didpool/register/registration_success.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class SelectGoalScreen extends StatefulWidget {
//   const SelectGoalScreen({super.key});

//   @override
//   State<SelectGoalScreen> createState() => _SelectGoalScreenState();
// }

// class _SelectGoalScreenState extends State<SelectGoalScreen> {
//   PageController pageController = PageController();
//   int activeimage = 0;

//   List<dynamic> images = [
//     {'image': 'assets/first.png'},
//     {'image': 'assets/best.png'},
//     {'image': 'assets/program.png'},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             SizedBox(height: 40.h),
//             Center(
//               child: AppText(
//                 'What is your goal?',
//                 fontSize: 20.sp,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.white,
//               ),
//             ),
//             SizedBox(height: 4.h),
//             AppText(
//               'It will help us to choose the best\nprogram for you',
//               fontSize: 12.sp,
//               fontWeight: FontWeight.w400,
//               color: Colors.grey,
//             ),
//             SizedBox(height: 40.h),
//             SizedBox(
//               height: 500.h,
//               width: double.infinity,
//               child: PageView.builder(
//                 scrollDirection: Axis.horizontal,
//                 controller: pageController,
//                 itemCount: images.length,
//                 onPageChanged: (value) {
//                   setState(() {
//                     activeimage = value;
//                   });
//                 },
//                 itemBuilder: (context, index) {
//                   return Image.asset(images[index]['image'],);
//                 },
//               ),
//             ),
//             SizedBox(
//               height: 50.h,
//             ),
//             Custombutton(
//               title: 'Confirm',
//               ontap: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => RegistrationSuccess()));
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
