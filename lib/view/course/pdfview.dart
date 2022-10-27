import 'dart:io';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PdfViewScreen extends StatefulWidget {
  final String url;
  const PdfViewScreen({Key? key, required this.url}) : super(key: key);

  @override
  State<PdfViewScreen> createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfViewScreen> {
  String? localPath;
  @override
  void initState() {
    loadPDF(widget.url).then((value) {
      setState(() {
        localPath = value;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  static Future loadPDF(String url) async {
    var response = await http.get(
      Uri.parse(url),
    );
    var dir = await getApplicationDocumentsDirectory();
    File file = File("${dir.path}/data.pdf");

    file.writeAsBytesSync(response.bodyBytes, flush: true);
    return file.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: localPath != null
          ? PDFView(
              autoSpacing: true,
              enableSwipe: true,
              filePath: localPath,
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
