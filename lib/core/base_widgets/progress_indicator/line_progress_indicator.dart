// import 'package:acak_soal/core/ext/ctx_ext.dart';
// import 'package:acak_soal/core/ext/list_ext.dart';
// import 'package:flutter/material.dart';

// class LineProgressIndicator extends StatelessWidget {
//   final List<String> listOfText;
//   final int currentProgress;
//   final double lineToCircleRatio;
//   final Color activeColor;
//   final Color disableColor;
//   const LineProgressIndicator(
//       {Key? key,
//       required this.listOfText,
//       this.currentProgress = -1,
//       this.lineToCircleRatio = 3,
//       required this.activeColor,
//       required this.disableColor})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(builder: (context, constraint) {
//       final availableSpace = constraint.maxWidth;
//       final numberOfItem = listOfText.length;
//       var eachItemSize = availableSpace / numberOfItem;
//       final initialCircleSize = eachItemSize / lineToCircleRatio;
//       final circleSize = initialCircleSize > constraint.maxHeight
//           ? constraint.maxHeight
//           : initialCircleSize;
//       final eachSpaceRemaining =
//           (eachItemSize - circleSize) / (numberOfItem - 1);
//       final lineSize = eachItemSize - circleSize + eachSpaceRemaining;
//       return Stack(
//         children: [
//           Positioned(
//             top: circleSize / 2,
//             child: Row(
//               children: listOfText.mapIndexed(((index, item) {
//                 final isLastItem = index == numberOfItem - 1;
//                 final isActive = index <= currentProgress;
//                 return !isLastItem
//                     ? Padding(
//                         padding: EdgeInsets.only(left: circleSize),
//                         child: SizedBox(
//                           width: lineSize,
//                           child: _ProgressLine(
//                             color: isActive ? activeColor : disableColor,
//                           ),
//                         ),
//                       )
//                     : const SizedBox();
//               })),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: listOfText.mapIndexed(((index, item) {
//               final isLastItem = index == numberOfItem - 1;
//               final isActive = index <= currentProgress;
//               return _ProgressItem(
//                 color: isActive ? activeColor : disableColor,
//                 showLine: !isLastItem,
//                 number: (index + 1).toString(),
//                 text: Text(item),
//                 circleSize: circleSize,
//               );
//             })),
//           ),
//         ],
//       );
//     });
//   }
// }

// class _ProgressLine extends StatelessWidget {
//   final Color color;
//   const _ProgressLine({Key? key, required this.color}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 5,
//       width: double.infinity,
//       decoration: BoxDecoration(shape: BoxShape.rectangle, color: color),
//     );
//   }
// }

// class _ProgressItem extends StatelessWidget {
//   final Text text;
//   final Color color;
//   final String number;
//   final bool showLine;
//   final double circleSize;

//   const _ProgressItem(
//       {Key? key,
//       required this.text,
//       required this.color,
//       required this.number,
//       required this.showLine,
//       required this.circleSize})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//             child: Row(
//           children: [
//             CircleAvatar(
//               backgroundColor: color,
//               child: FittedBox(child: Text(number),),
//               radius: circleSize,
//             ),
//           ],
//         )),
//       ],
//     );
//   }
// }
