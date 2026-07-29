import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:small_faith/features/homescreen/widget/devotion_history_card.dart';

class DevotionHistory extends StatefulWidget {
  const DevotionHistory({super.key});

  @override
  State<DevotionHistory> createState() => _DevotionHistoryState();
}

class _DevotionHistoryState extends State<DevotionHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 56.w,
        titleSpacing: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'History',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w900,
            fontSize: 20.sp,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(padding: EdgeInsets.all(20.r), child: Column(
        children: [
          SizedBox(width: double.infinity,
          child: DevotionHistoryCard(),),
          
          
        ],
      )),
    );
  }
}
