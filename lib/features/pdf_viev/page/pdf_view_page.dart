import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:new_billing/core/common/widgets/app_bar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';

class PDFScreen extends StatefulWidget {
  final String pdfUrl;
  const PDFScreen({super.key, required this.pdfUrl});

  @override
  State<PDFScreen> createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  String? localPdfPath;
  bool isLoading = true;
  bool isDownloading = false;

  @override
  void initState() {
    super.initState();
    _downloadAndSavePdf();
  }

  // Function to check and request permissions
  Future<void> _checkPermissions() async {
    if (Platform.isAndroid) {
      final status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
    }
  }

  // Function to download the PDF and save it to the Downloads directory using MediaStore
  Future<void> _downloadAndSavePdf() async {
    await _checkPermissions();

    try {
      final response = await http.get(Uri.parse(widget.pdfUrl));
      if (response.statusCode == 200) {
        final directory = await getExternalStorageDirectory();

        // For Android 10+, use MediaStore to save files in Downloads
        if (Platform.isAndroid && await Permission.storage.isGranted) {
          final intent = AndroidIntent(
            action: 'android.intent.action.VIEW',
            data: Uri.parse(widget.pdfUrl).toString(),
            type: 'application/pdf',
            package: 'com.android.chrome',
            flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
          );
          await intent.launch();

          setState(() {
            isLoading = false;
            localPdfPath = 'File has been successfully downloaded to Downloads.';
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("PDF Downloaded Successfully")),
          );
        } else {
          // For Android 9 and lower, save directly to external storage
          final tempDir = await getTemporaryDirectory();
          final file = File("${tempDir.path}/downloaded.pdf");
          await file.writeAsBytes(response.bodyBytes);
          setState(() {
            localPdfPath = file.path;
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("PDF Downloaded to temporary location")),
          );
        }
      } else {
        throw Exception("Failed to load PDF");
      }
    } catch (e) {
      print("Error downloading PDF: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  // Function to initiate download of the PDF file to Downloads directory
  Future<void> _downloadFile() async {
    setState(() {
      isDownloading = true;
    });

    await _checkPermissions();

    try {
      final response = await http.get(Uri.parse(widget.pdfUrl));
      if (response.statusCode == 200) {
        // For Android, get the Downloads directory path
        final directory = await getExternalStorageDirectory();
        final downloadsDirectory = Directory("${directory!.path}/Download");

        if (!(await downloadsDirectory.exists())) {
          await downloadsDirectory.create(recursive: true);
        }

        final file = File("${downloadsDirectory.path}/downloaded.pdf");
        await file.writeAsBytes(response.bodyBytes);

        setState(() {
          isDownloading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("PDF Downloaded Successfully")),
        );
      } else {
        throw Exception("Failed to load PDF");
      }
    } catch (e) {
      setState(() {
        isDownloading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to download PDF: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar().build(context),
      body: Column(
        children: [
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : localPdfPath == null
                    ? const Center(child: Text("Failed to load PDF"))
                    : PDFView(filePath: localPdfPath!),
          ),
          if (!isDownloading)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _downloadFile,
                child: const Text("Download PDF to Downloads Directory"),
              ),
            ),
          if (isDownloading)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: const CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
