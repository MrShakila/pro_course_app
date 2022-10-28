import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pro_course_app/Utils/navigation.dart';
import 'package:pro_course_app/model/chat_user.dart';

import '../../const/keyboardutils.dart';
import '../../const/size.dart';
import '../../view/chat/chat_page.dart';

Widget buildUserLIst(BuildContext context, DocumentSnapshot? documentSnapshot,
    String currentUserId) {
  final firebaseAuth = FirebaseAuth.instance;
  if (documentSnapshot != null) {
    ChatUser userChat = ChatUser.fromDocument(documentSnapshot);
    if (userChat.id == currentUserId) {
      return const SizedBox.shrink();
    } else {
      return TextButton(
        onPressed: () {
          if (KeyboardUtils.isKeyboardShowing()) {
            KeyboardUtils.closeKeyboard(context);
          }
          UtilFunctions.navigateTo(
              context,
              ChatPage(
                peerId: userChat.id,
                peerAvatar: userChat.photoUrl,
                peerNickname: userChat.displayName,
                // userAvatar: firebaseAuth.currentUser!.photoURL,
              ));
        },
        child: ListTile(
          leading: userChat.photoUrl.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(Sizes.dimen_30),
                  child: Image.network(
                    userChat.photoUrl,
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                    loadingBuilder: (BuildContext ctx, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                              color: Colors.grey,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null),
                        );
                      }
                    },
                    errorBuilder: (context, object, stackTrace) {
                      return const Icon(Icons.account_circle, size: 50);
                    },
                  ),
                )
              : const Icon(
                  Icons.account_circle,
                  size: 50,
                ),
          title: Text(
            userChat.displayName,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      );
    }
  } else {
    return const SizedBox.shrink();
  }
}
