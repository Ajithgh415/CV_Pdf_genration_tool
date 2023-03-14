import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdf;
import 'package:permission_handler/permission_handler.dart';

import 'package:open_file/open_file.dart' as open_file;
import 'package:path_provider/path_provider.dart' as path_provider;

class CvGeneratorApp extends StatefulWidget {
  @override
  _CvGeneratorAppState createState() => _CvGeneratorAppState();
}

class _CvGeneratorAppState extends State<CvGeneratorApp> {
  File? _signatureImage;
  String? _dateTime;
  String? fileopen = "";

  @override
  void initState() {
    super.initState();
    _dateTime = DateTime.now().toString();
  }

  Future<bool> _checkPermission() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      // You can request multiple permissions at once.
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();
      return statuses[Permission.storage] == PermissionStatus.granted;
    } else {
      return true;
    }
  }

  Future<void> _generatePdf() async {
    final pdf.Document document = pdf.Document();

    // // Add CV heading
    // document.addPage(
    //   pdf.Page(
    //     pageFormat: PdfPageFormat.a4,
    //     build: (pdf.Context context) {
    //       return pdf.Column(children: [pdf.Header(title: "CV"),pdf.c]);
    //       // child:
    //       //  pdf.Text('CV', style: pdf.TextStyle(fontSize: 24)),
    //       // child: pdf.Header(title: "CV"));
    //     },
    //   ),
    // );

    // Add signature image
    if (_signatureImage != null) {
      final Uint8List signatureBytes = await _signatureImage!.readAsBytes();
      final pdf.Image signaturePdfImage = pdf.Image(
        pdf.MemoryImage(signatureBytes),
      );
      document.addPage(
        pdf.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pdf.Context context) {
            // return pdf.Center(
            //   child: signaturePdfImage,
            // );
            return pdf.Column(
              crossAxisAlignment: pdf.CrossAxisAlignment.center,
              mainAxisAlignment: pdf.MainAxisAlignment.spaceBetween,
              children: [
                pdf.Center(
                    child: pdf.Text("CV",
                        style: pdf.TextStyle(
                            fontSize: 20, fontWeight: pdf.FontWeight.bold))),
                pdf.Column(
                    crossAxisAlignment: pdf.CrossAxisAlignment.start,
                    mainAxisAlignment: pdf.MainAxisAlignment.end,
                    children: [
                      pdf.Row(children: [
                        pdf.Text("Signature"),
                        pdf.SizedBox(width: 20),
                        pdf.Image(pdf.MemoryImage(signatureBytes),
                            width: 50, height: 50),
                      ]),
                      pdf.SizedBox(height: 10),
                      pdf.Text("Date: ${DateTime.now().toString()}"),
                    ])
              ],
            );
          },
        ),
      );
    }

    // // Add current date and time
    // document.addPage(
    //   pdf.Page(
    //     pageFormat: PdfPageFormat.a4,
    //     build: (pdf.Context context) {
    //       return pdf.Center(
    //         child: pdf.Text(_dateTime!, style: pdf.TextStyle(fontSize: 18)),
    //       );
    //     },
    //   ),
    // );
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if (await Permission.storage.request().isGranted) {
      try {
        // Save PDF file to device storage

        final Directory? directory = await getExternalStorageDirectory();
        // final String downloadsPath = '/storage/emulated/0/Download';
        // String path = directory!.path.split('/').indexOf("0/").toString();
        final String downloadsPath = '${directory!.path}/Download';
        // final downloadsDirectory1 = Directory('/storage/emulated/0/Download');
        final Directory downloadsDirectory = Directory(downloadsPath);
        await downloadsDirectory.create(recursive: true);
        print(downloadsDirectory.path);
        final now = DateTime.now().millisecondsSinceEpoch;
        // Generate a random string of length 4
        final random = Random();
        final randString = String.fromCharCodes(
            List.generate(4, (_) => random.nextInt(26) + 65));
        final String userId = 'PDF$now$randString';
        final String filePath = '${downloadsDirectory.path}/$userId.pdf';
        print(filePath);
        final File file = File(filePath);
        final Uint8List pdfBytes = await document.save();
        MimeType type = MimeType.PDF;
        String path = await FileSaver.instance
            .saveFile("cv", pdfBytes, ".pdf", mimeType: type);
        setState(() {
          fileopen = path;
        });
        saveAndLaunchFile(filePath, type.toString());
        await file.writeAsBytes(pdfBytes);
        // await open_file.OpenFile.open(filePath, type: type.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('PDF generated: $path')),
        );
      } catch (e) {
        print(e);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Permission Denied")),
      );
    }
  }

  ///To save the pdf file in the device
  Future<void> saveAndLaunchFile(String path, String fileName) async {
    //Get the storage folder location using path_provider package.
    await open_file.OpenFile.open(path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CV Generator')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            Text('Upload your signature image:'),
            SizedBox(height: 8),
            _signatureImage != null
                ? Image.file(
                    File(_signatureImage!.path),
                    width: 100,
                    height: 100,
                  )
                : Container(),
            ElevatedButton(
              onPressed: () async {
                final imagePicker = ImagePicker();
                final pickedFile = await imagePicker.getImage(
                  source: ImageSource.gallery,
                );
                if (pickedFile != null) {
                  setState(() {
                    _signatureImage = File(pickedFile.path);
                  });
                }
              },
              child: Text('Select image'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (_signatureImage != null) {
                    _generatePdf();
                  }
                });
              },
              child: Text('Generate PDF'),
            ),
            Visibility(
              visible: fileopen != "" ? true : false,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (fileopen != "" || _signatureImage != null) {
                      saveAndLaunchFile(fileopen!, "");
                    }
                  });
                },
                child: Text('View Generated file'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
