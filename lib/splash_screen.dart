import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pdf/pdf.dart';
import 'home_page.dart';
import 'pdf_generator.dart'; // Import the PDF generation file
import 'package:printing/printing.dart'; // Import for PdfPreview
import 'dart:typed_data'; // Import for Uint8List

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () async {
      try {
        // Generate the resume PDF
        final pdf = await generateResume(PdfPageFormat.a4);
        // Navigate to the PDF preview page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PdfPreviewPage(pdf: pdf)),
        );
      } catch (e) {
        // If there's an error, print it for debugging
        print('Error generating PDF: $e');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('profile_pic/char.jpg'),
            ),
            Text(
              'Tanay Naphade',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                fontFamily: 'Sevillana',
              ),
            ),
            Text(
              'FLUTTER DEVELOPER',
              style: TextStyle(
                fontSize: 20,
                letterSpacing: 2.5,
                fontWeight: FontWeight.bold,
                fontFamily: 'SourceSans3',
              ),
            ),
            SizedBox(
              height: 20,
              width: 150,
              child: Divider(
                color: Colors.black54,
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              color: Colors.black,
              child: ListTile(
                leading: Icon(
                  Icons.call,
                  color: Colors.white,
                ),
                title: Text(
                  '+91 8421796585',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'SourceSans3',
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              color: Colors.black,
              child: ListTile(
                leading: Icon(
                  Icons.mail_outline,
                  color: Colors.white,
                ),
                title: Text(
                  'tanaynaphade9@gmail.com',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'SourceSans3',
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
