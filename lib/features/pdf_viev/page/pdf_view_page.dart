import 'package:flutter/material.dart';
import 'package:new_billing/core/common/widgets/app_bar.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


class PdfViewPage extends StatefulWidget {
  final String url;
  const PdfViewPage({super.key , required this.url});

  @override
  State<PdfViewPage> createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar().build(context),
      body: SfPdfViewer.network(widget.url),
    );
  }
}