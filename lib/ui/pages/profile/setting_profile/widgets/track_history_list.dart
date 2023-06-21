import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TrackHistoryList extends StatelessWidget {
  const TrackHistoryList({Key? key, required this.list}) : super(key: key);

  final List<Map> list;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) => ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 1.h),
        onTap: () {},
        leading: Image.asset(
          '${list[index]["background_image"]}',
          width: 40.sp,
          height: 40.sp,
        ),
        title: Text(
          '${list[index]["name"]}',
        ),
        trailing: const Icon(Icons.play_arrow_outlined),
      ),
    );
  }
}
