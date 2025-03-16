import 'package:didpool/home/workout_details.dart';
import 'package:didpool/components/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkerTracker extends StatefulWidget {
  const WorkerTracker({super.key});

  @override
  State<WorkerTracker> createState() => _WorkerTrackerState();
}

class _WorkerTrackerState extends State<WorkerTracker> {
  bool best = false;
  bool more = false;

  List<dynamic> train = [
    {
      'title': 'fullbody workout',
      'subtitle': 'Today , 03:00pm',
      'message': 'Edit',
      'image': 'assets/view mod.png',
      'imagepath': "assets/Ellipse.png",
    },
    {
      'title': 'fullbody workout',
      'subtitle': 'Today , 03:00pm',
      'message': 'Edit',
      'image': 'assets/view mod.png',
      'imagepath': "assets/Ellipse.png",
    },
    {
      'title': 'fullbody workout',
      'subtitle': 'Today , 03:00pm',
      'message': 'Edit',
      'image': 'assets/view mod.png',
      'imagepath': "assets/Ellipse.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40.h,
                ),
                Container(
                  height: 57.h,
                  width: 315.w,
                  decoration: BoxDecoration(
                      color: Color(0xff412a51),
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      children: [
                        AppText(
                          'Daily Workout Schedule',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffE9E3E4),
                        ),
                        Spacer(),
                        Container(
                          height: 28.h,
                          width: 68.w,
                          decoration: BoxDecoration(
                            color: Color(0xff4023D7),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: AppText(
                              'Check',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xffE9E3E4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  children: [
                    AppText(
                      'Upcoming Workout',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffE9E3E4),
                    ),
                    Spacer(),
                    AppText(
                      'See more',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30.r,
                      backgroundImage: AssetImage(
                        "assets/best (2).png",
                      ),
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          'Fullbody Workout',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffE9E3E4),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        AppText(
                          'Today, 03:00pm',
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    Spacer(),
                    Switch(
                      value: more,
                      onChanged: (value) {
                        setState(() {
                          more = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30.r,
                      backgroundImage: AssetImage(
                        "assets/best (2).png",
                      ),
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          'Upperbody Workout',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffE9E3E4),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        AppText(
                          'June 05, 02:00pm',
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    Spacer(),
                    Switch(
                      value: best,
                      onChanged: (value) {
                        setState(() {
                          best = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                AppText(
                  'What Do You Want to Train',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffE9E3E4),
                ),
                SizedBox(
                  height: 30.h,
                ),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: train.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                        height: 132.h,
                        width: 315.w,
                        decoration: BoxDecoration(
                            color: Color(0xff412a51),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  AppText(
                                    train[index]['title'],
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xffE9E3E4),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  AppText(
                                    train[index]['subtitle'],
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  WorkoutDetails()));
                                    },
                                    child: Container(
                                      height: 30.h,
                                      width: 83.w,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Center(
                                        child: AppText(
                                          train[index]['message'],
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 70),
                                child: Stack(
                                  children: [
                                    Image.asset(
                                      train[index]['imagepath'],
                                      scale: 4,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Image.asset(
                                        train[index]['image'],
                                        scale: 4.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 50.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
