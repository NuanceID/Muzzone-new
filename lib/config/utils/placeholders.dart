import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muzzone/config/constants/constants.dart';

class TrendsPlaceholder extends StatelessWidget {
  const TrendsPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Container(),
        ),
        Flexible(
          flex: 14,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                  child: Row(
                children: [
                  Flexible(
                    child: Container(
                      height: (availableHeight / 2.42) / 10,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Colors.white),
                    ),
                  ),
                  Flexible(
                    child: Container(),
                  ),
                  Flexible(
                    child: Container(
                      height: (availableHeight / 2.42) / 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )),
              Flexible(
                child: Container(
                  height: (availableHeight / 2.42) / 18.9,
                ),
              ),
              Flexible(
                  child: Container(
                height: availableHeight / 13,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Colors.white),
              )),
              Flexible(
                child: Container(
                  height: (availableHeight / 2.42) / 30,
                ),
              ),
              Flexible(
                  child: Container(
                height: availableHeight / 13,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Colors.white),
              )),
              Flexible(
                child: Container(
                  height: (availableHeight / 2.42) / 30,
                ),
              ),
              Flexible(
                  child: Container(
                height: availableHeight / 13,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Colors.white),
              )),
              Flexible(
                child: Container(
                  height: (availableHeight / 2.42) / 30,
                ),
              ),
              Flexible(
                  child: Container(
                height: availableHeight / 13,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Colors.white),
              ))
            ],
          ),
        ),
        Flexible(
          child: Container(),
        ),
      ],
    );
  }
}

class MainTilePlaceholder extends StatelessWidget {
  const MainTilePlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Flexible(
        child: Container(),
      ),
      Flexible(
        flex: 14,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
                child: Row(
              children: [
                Flexible(
                  child: Container(
                    height: availableHeight / 25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Colors.white),
                  ),
                ),
                Flexible(
                  child: Container(),
                ),
                Flexible(
                  child: Container(
                    height: availableHeight / 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )),
            Flexible(
              child: SizedBox(
                height: availableHeight / 80,
              ),
            ),
            Flexible(
                child: SizedBox(
                    height: availableHeight / 4,
                    child: ListView.builder(
                      itemCount: 3,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          width: availableHeight / 4,
                          height: availableHeight / 4,
                          margin:
                              EdgeInsets.only(right: index == 2 ? 14.w : 12.w),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r)),
                        );
                      },
                    )))
          ],
        ),
      ),
      Flexible(
        child: Container(),
      ),
    ]);
  }
}
