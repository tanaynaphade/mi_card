import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'pdf_generator.dart'; // Import the PDF generation file
import 'dart:typed_data';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume Preview'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              // Generate the resume PDF
              final pdf = await generateResume(PdfPageFormat.a4);
              // Navigate to the PDF preview page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PdfPreviewPage(pdf: pdf),
                ),
              );
            } catch (e) {
              // If there's an error, print it for debugging
              print('Error generating PDF: $e');
            }
          },
          child: const Text('View My Resume'),
        ),
      ),
    );
  }
}

class PdfPreviewPage extends StatelessWidget {
  final Uint8List pdf;

  const PdfPreviewPage({Key? key, required this.pdf}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (format) async => pdf,
        allowSharing: true,
        allowPrinting: true,
        canChangeOrientation: false,
        canChangePageFormat: false,
      ),
    );
  }
}
