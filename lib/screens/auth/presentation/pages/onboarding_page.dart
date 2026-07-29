import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    
    _timer = Timer.periodic(const Duration(seconds: 7), (timer) {
      if (_pageController.hasClients) {
        int currentPage = _pageController.page?.round() ?? 0;
        
        if (currentPage < 2) {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOutCubic,
          );
        } else {
          timer.cancel();
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 0.w, bottom: 0.h),
                child: Image.asset("assets/images/onboarding_hi.png"),
              ),
            ),
            PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 195.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi there.",
                        style: TextStyle(
                          fontFamily: 'Inter', 
                          fontSize: 48.sp, 
                          fontWeight: FontWeight.w900, 
                          color: Colors.white,
                        ),
                      ),
                      
                      Text(
                        "We're so glad you found us.",
                        style: TextStyle(
                          fontFamily: 'Inter', 
                          fontSize: 20.sp, 
                          fontWeight: FontWeight.normal, 
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 195.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome to",
                        style: TextStyle(
                          fontFamily: 'Inter', 
                          fontSize: 48.sp, 
                          fontWeight: FontWeight.w900, 
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "SMALL FAITH",
                        style: TextStyle(
                          fontFamily: 'Inter', 
                          fontSize: 48.sp, 
                          fontWeight: FontWeight.w900, 
                          color: Colors.white,
                        ),
                      ),
                      
                      Text(
                        "A safe, supportive space to explore your beliefs, share your journey, and grow alongside others.",
                        style: TextStyle(
                          fontFamily: 'Inter', 
                          fontSize: 20.sp, 
                          fontWeight: FontWeight.normal, 
                          height: 1.4,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    debugPrint("Screen Tapped");
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 195.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ready to\nfind your\npeople?",
                          style: TextStyle(
                            fontFamily: 'Inter', 
                            fontSize: 48.sp, 
                            height: 1.1,
                            fontWeight: FontWeight.w900, 
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            Text(
                              "Tap anywhere to get started",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white70,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white70,
                              size: 16.sp,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}