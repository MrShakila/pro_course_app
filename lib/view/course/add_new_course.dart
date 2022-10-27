import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/material.dart';
import 'package:pro_course_app/view/textfieldlog.dart';
import 'package:provider/provider.dart';

import '../../admin/save_course_detail.dart';

class SaveCourseInfo extends StatelessWidget {
  const SaveCourseInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final description = TextEditingController();
    final price = TextEditingController();
    final title = TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.grey[300],
      body: Center(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(
              Icons.anchor,
              size: 50,
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Save Course Details",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldLog(
                title: "Title",
                icon: const Icon(
                  Icons.book,
                  color: Colors.black,
                ),
                controller: title,
                textInputType: TextInputType.text),
            TextFieldLog(
                title: "Description",
                icon: const Icon(
                  Icons.description,
                  color: Colors.black,
                ),
                controller: description,
                textInputType: TextInputType.text),
            TextFieldLog(
                title: "Price",
                icon: const Icon(
                  Icons.price_check,
                  color: Colors.black,
                ),
                controller: price,
                textInputType: TextInputType.number),
            Consumer<Course>(
              builder: (context, value, child) {
                return value.getImage.path == ""
                    ? TextButton(
                        onPressed: () async {
                          Provider.of<Course>(context, listen: false)
                              .selectImage();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(25)),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 15),
                            child: Text(
                              "Uplod Iamge",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ))
                    : InkWell(
                        onTap: () {
                          value.selectImage();
                        },
                        child: Image.file(value.getImage));
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Consumer<Course>(
              builder: (context, value, child) {
                return TextButton(
                    onPressed: () {
                      // check image is picked

                      if (value.getImage.path == '') {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.ERROR,
                          animType: AnimType.BOTTOMSLIDE,
                          title: 'Error',
                          desc: 'Please picked the image',
                          btnOkOnPress: () {},
                        ).show();
                      } else {
                        if (title.text.isNotEmpty &&
                            description.text.isNotEmpty &&
                            price.text.isNotEmpty) {
                          value.startSaveBookInfo(context, title.text.trim(),
                              description.text.trim(), price.text.trim());
                          title.clear();
                          description.clear();
                          price.clear();

                          imageCache.clear();
                        } else {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.ERROR,
                            animType: AnimType.BOTTOMSLIDE,
                            title: 'Error',
                            desc: 'Please fill all the fields',
                            btnOkOnPress: () {},
                          ).show();
                        }
                      }
                      //check all the text fields
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(25)),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        child: Center(
                          child: Text(
                            "Save Book Info",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ));
              },
            )
          ]),
        ),
      ),
    );
  }
}
