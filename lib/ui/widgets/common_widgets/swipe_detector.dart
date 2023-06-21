// import 'package:flutter/material.dart';
//
// class SwipeDetector extends StatelessWidget {
//   final Widget child;
//   final VoidCallback? onSwipeToLeft;
//   final VoidCallback? onSwipeToRight;
//
//   const SwipeDetector({
//     Key? key,
//     required this.child,
//     this.onSwipeToLeft,
//     this.onSwipeToRight,
//   }) : super(key: key);
//
//   void _handleHorizontalDrag(DragUpdateDetails details) {
//     if (details.delta.dx < -1 && onSwipeToRight != null) {
//       onSwipeToRight!();
//     }
//     if (details.delta.dx > 1 && onSwipeToLeft != null) {
//       onSwipeToLeft!();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onHorizontalDragUpdate: _handleHorizontalDrag,
//       child: child,
//     );
//   }
// }
