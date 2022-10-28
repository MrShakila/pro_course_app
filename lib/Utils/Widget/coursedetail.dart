import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_course_app/Utils/navigation.dart';
import 'package:provider/provider.dart';

import '../../admin/save_course_detail.dart';
import '../../view/course/pdfview.dart';

class DetailWidget extends StatelessWidget {
  final String title;
  final String desc;
  final String imag;
  final String pdfurl;
  final double star;
  final String id;
  const DetailWidget({
    Key? key,
    required this.size,
    required this.title,
    required this.desc,
    required this.imag,
    required this.id,
    required this.star,
    required this.pdfurl,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(flex: 1, child: Image.network(imag)),
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  width: double.infinity,
                  height: size.height / 2,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                title,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: Row(
                                  children: [
                                    Stack(
                                      children: const [
                                        Icon(
                                          Icons.star,
                                          color: Colors.black,
                                          size: 27,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                          size: 25,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      star.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )
                                  ],
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          desc,
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.normal, fontSize: 15),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                            child: Row(
                          children: [
                            const Text("View Syllabus"),
                            IconButton(
                                onPressed: () {
                                  UtilFunctions.navigateTo(
                                      context,
                                      PdfViewScreen(
                                        url: pdfurl,
                                      ));
                                },
                                icon: const Icon(Icons.arrow_forward))
                          ],
                        )),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(child: Consumer<Course>(
                          builder: (context, value, child) {
                            return ElevatedButton(
                                onPressed: () {
                                  value.addNewStudentToCourse(context, id);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("Enroll Now"),
                                ));
                          },
                        ))
                      ],
                    ),
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
