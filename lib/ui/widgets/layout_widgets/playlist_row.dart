import 'package:flutter/material.dart';
import 'package:muzzone/config/config.dart';
import 'package:muzzone/ui/widgets/buttons/three_dots_button.dart';
import 'package:sizer/sizer.dart';

import '../../../data/data.dart';

mixin PlaylistRowImageMixin on StatelessWidget {
  Widget buildImage(BuildContext context, MyPlaylist playlist, double height) {
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                '$imagesMainPagePath${playlist.image}.png',
              ),
              fit: BoxFit.cover)),
    );
  }
}

mixin PlaylistRowTextMixin on StatelessWidget {
  Widget buildText(BuildContext context, MyPlaylist playlist) {
    return Padding(
      padding: EdgeInsets.only(
        left: 3.w,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            playlist.title,
            style: TextStyle(
              fontSize: playlist.title.length > 22 ? 10.sp : 12.sp,
            ),
          )
        ],
      ),
    );
  }
}

class PlaylistRow extends StatelessWidget with PlaylistRowImageMixin {
  const PlaylistRow({
    Key? key,
    required this.onPress,
    required this.playlist,
    this.paddingLeft,
    required this.height,
  }) : super(key: key);

  final MyPlaylist playlist;
  final Function() onPress;
  final double height;
  final double? paddingLeft;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(left: paddingLeft ?? 7.w, right: 7.w, bottom: 2.h),
      child: GestureDetector(
        onTap: onPress,
        child: PlaylistTile(
          playlist: playlist,
          height: height,
          imageWidget: buildImage(context, playlist, height),
        ),
      ),
    );
  }
}

class PlaylistTile extends StatelessWidget
    with PlaylistRowImageMixin, PlaylistRowTextMixin {
  const PlaylistTile({
    Key? key,
    required this.playlist,
    required this.height,
    required this.imageWidget,
  }) : super(key: key);

  final MyPlaylist playlist;
  final double height;
  final Widget imageWidget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: height,
      child: Card(
        color: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        margin: EdgeInsets.zero,
        child: Row(
          children: [
            imageWidget,
            buildText(context, playlist),
            const Spacer(),
            ThreeDotsButton(audio: playlist.audios, fromPage: ''),
          ],
        ),
      ),
    );
  }
}
