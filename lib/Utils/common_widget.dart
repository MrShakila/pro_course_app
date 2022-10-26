import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:pro_course_app/const/size.dart';

import '../const/app_colors.dart';

Widget errorContainer() {
  return Container(
    clipBehavior: Clip.hardEdge,
    child: Image.asset(
      'assets/images/img_not_available.jpeg',
      height: Sizes.dimen_200,
      width: Sizes.dimen_200,
    ),
  );
}

Widget chatImage({required String imageSrc, required Function onTap}) {
  return OutlinedButton(
    onPressed: onTap(),
    child: Image.network(
      imageSrc,
      width: Sizes.dimen_200,
      height: Sizes.dimen_200,
      fit: BoxFit.cover,
      loadingBuilder:
          (BuildContext ctx, Widget child, ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          decoration: BoxDecoration(
            color: AppColors.greyColor2,
            borderRadius: BorderRadius.circular(Sizes.dimen_10),
          ),
          width: Sizes.dimen_200,
          height: Sizes.dimen_200,
          child: Center(
            child: CircularProgressIndicator(
              color: AppColors.burgundy,
              value: loadingProgress.expectedTotalBytes != null &&
                      loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          ),
        );
      },
      errorBuilder: (context, object, stackTrace) => errorContainer(),
    ),
  );
}

// Widget messageBubble(
//     {required String chatContent,
//     required EdgeInsetsGeometry? margin,
//     Color? color,
//     Color? textColor}) {
//   return Container(
//     padding: const EdgeInsets.all(Sizes.dimen_10),
//     margin: margin,
//     width: Sizes.dimen_200,
//     decoration: BoxDecoration(
//       color: color,
//       borderRadius: BorderRadius.circular(Sizes.dimen_10),
//     ),
//     child: Text(
//       chatContent,
//       style: TextStyle(fontSize: Sizes.dimen_16, color: textColor),
//     ),
//   );
//
//}

Widget messageBubble(
    {required String chatContent,
    required bool isSender,
    required EdgeInsetsGeometry? margin,
    Color? color,
    Color? textColor}) {
  return BubbleSpecialThree(
    text: chatContent,
    color: isSender ? Colors.blue : Colors.deepOrangeAccent,
    tail: false,
    isSender: isSender,
    textStyle: const TextStyle(color: Colors.white, fontSize: 16),
  );
}
