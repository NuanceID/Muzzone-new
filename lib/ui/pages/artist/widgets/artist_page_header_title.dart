import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/widgets.dart';

class ArtistPageHeaderTitle extends StatelessWidget {
  const ArtistPageHeaderTitle(
      {Key? key, required this.image, required this.name})
      : super(key: key);

  final String image;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40.h,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              'https://uhd.name/uploads/posts/2020-09/thumbs/1600716792_25-p-yulduz-usmanova-120.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeaderTitle(),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: 4.h, left: 10.w),
            child: Text(
              name,
              style: TextStyle(color: Colors.white, fontSize: 20.sp),
            ),
          ),
        ],
      ),
    );
  }
}
