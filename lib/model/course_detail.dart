import 'package:flutter/material.dart';

class CourseDetail extends StatelessWidget {
  const CourseDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: double.infinity,
          height: size.height,
          color: Colors.red,
        ),
        Align(
          alignment: Alignment.bottomCenter,
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
                        const Expanded(
                          flex: 3,
                          child: Text(
                            "Flutter Mobile App \nDevelopment",
                            style: TextStyle(
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
                                const Text(
                                  "4.5",
                                  style: TextStyle(
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
                    const Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type",
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: ElevatedButton(
                          onPressed: () {},
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Enroll Now"),
                          )),
                    )
                  ],
                ),
              )),
        ),
      ],
    ));
  }
}
