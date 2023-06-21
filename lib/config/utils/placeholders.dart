import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TrendsPlaceholder extends StatelessWidget {
  const TrendsPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                width: 30.w,
                height: 4.h,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                width: 30.w,
                height: 4.h,
              ),
            ],
          ),
          SizedBox(height: 2.05.h),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            padding: EdgeInsets.only(left: 7.w, right: 7.w, bottom: 2.h),
            width: 100.w,
            height: 8.h,
          ),
          SizedBox(height: 2.h),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            padding: EdgeInsets.only(left: 7.w, right: 7.w, bottom: 2.h),
            width: 100.w,
            height: 8.h,
          ),
          SizedBox(height: 2.h),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            padding: EdgeInsets.only(left: 7.w, right: 7.w, bottom: 2.h),
            width: 100.w,
            height: 8.h,
          ),
          SizedBox(height: 2.h),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            padding: EdgeInsets.only(left: 7.w, right: 7.w, bottom: 2.h),
            width: 100.w,
            height: 8.h,
          )
        ],
      ),
    );
  }
}

class MainTilePlaceholder extends StatelessWidget {
  const MainTilePlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        children: [Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white),
              width: 30.w,
              height: 4.h,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white),
              width: 30.w,
              height: 4.h,
            ),
          ],
        ),
          SizedBox(height: 2.05.h),
          SizedBox(
              height: 120.sp,
              width: double.infinity,
              child: ListView.builder(
                itemCount: 3,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    width: 120.sp,
                    height: 120.sp,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.only(
                        left: index == 0 ? 2.w : 0, right: index == 3 ? 7.w : 3.w),
                  );
                },
              ))
        ],
      ),
    );
  }
}
