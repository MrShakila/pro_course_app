import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/material.dart';
import 'package:pro_course_app/const/app_colors.dart';
import 'package:pro_course_app/view/textfieldlog.dart';
import 'package:provider/provider.dart';

import '../../Utils/custo_drawer.dart';
import '../../admin/save_course_detail.dart';

class SaveCourseInfo extends StatelessWidget {
  const SaveCourseInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final description = TextEditingController();
    final star = TextEditingController();
    final pdfurl = TextEditingController();
    final title = TextEditingController();

    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: AppColors.indyBlue),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: const [],
        centerTitle: true,
        title: const Text(
          'Add New Course Details',
          style: TextStyle(color: AppColors.indyBlue),
        ),
      ),
      backgroundColor: Colors.grey[300],
      body: Container(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                title: "PdfUrl",
                icon: const Icon(
                  Icons.upload_rounded,
                  color: Colors.black,
                ),
                controller: pdfurl,
                textInputType: TextInputType.text),
            TextFieldLog(
                title: "Star Rating",
                icon: const Icon(
                  Icons.star,
                  color: Colors.black,
                ),
                controller: star,
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
                        child: SizedBox(
                            height: 100, child: Image.file(value.getImage)));
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
                            star.text.isNotEmpty) {
                          value.startSavecourseInfo(
                            context,
                            title.text.trim(),
                            description.text.trim(),
                            4,
                            pdfurl.text,
                          );
                          title.clear();
                          description.clear();
                          star.clear();

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
                            "Save Course Info",
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
