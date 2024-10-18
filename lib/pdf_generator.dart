import 'dart:typed_data';
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:google_fonts/google_fonts.dart';
import 'package:printing/printing.dart';

const PdfColor green = PdfColor.fromInt(0xff9ce5d0);
const PdfColor lightGreen = PdfColor.fromInt(0xffcdf1e7);
const sep = 120.0;

Future<Uint8List> generateResume(PdfPageFormat format) async {
  final doc = pw.Document(title: 'Tanay Naphade Résumé', author: 'Tanay Naphade');

  try {
    // Load the profile image from assets
    final profileImage = pw.MemoryImage(
      (await rootBundle.load('profile_pic/char.jpg')).buffer.asUint8List(),
    );

    final pageTheme = await _myPageTheme(format);

    doc.addPage(
      pw.MultiPage(
        pageTheme: pageTheme,
        build: (pw.Context context) => [
          pw.Partitions(
            children: [
              pw.Partition(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: <pw.Widget>[
                    pw.Container(
                      padding: const pw.EdgeInsets.only(left: 30, bottom: 20),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: <pw.Widget>[
                          pw.Text('Tanay Naphade',
                              textScaleFactor: 2,
                              style: pw.Theme.of(context)
                                  .defaultTextStyle
                                  .copyWith(fontWeight: pw.FontWeight.bold)),
                          pw.Padding(padding: const pw.EdgeInsets.only(top: 10)),
                          pw.Text('App Developer & Data Analyst',
                              textScaleFactor: 1.2,
                              style: pw.Theme.of(context)
                                  .defaultTextStyle
                                  .copyWith(
                                  fontWeight: pw.FontWeight.bold,
                                  color: green)),
                          pw.Padding(padding: const pw.EdgeInsets.only(top: 20)),
                          pw.Row(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                            children: <pw.Widget>[
                              pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: <pw.Widget>[
                                  pw.Text('Pune, MH, India'),
                                ],
                              ),
                              pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: <pw.Widget>[
                                  pw.Text('+91 8421796585'),
                                  _UrlText('tanaynaphade9@gmail.com',
                                      'mailto:tanaynaphade9@gmail.com'),
                                  _UrlText(
                                      'linkedin.com/in/tanay-naphade',
                                      'https://www.linkedin.com/in/tanay-naphade'),
                                  _UrlText(
                                      'github.com/tanaynaphade',
                                      'https://github.com/tanaynaphade'),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    _Category(title: 'Education'),
                    _Block(title: 'B.E. in Computer Engineering - 9.32 CGPA (PCCOER)', description: ''),
                    _Block(title: 'Diploma in Computer Engineering - 91.66% (Pimpri Chinchwad Polytechnic)', description: ''),
                    _Block(title: 'Central Board of Secondary Education - 85.44% (SNBP International School)', description: ''),
                    _Category(title: 'Experience'),
                    _Block(title: 'Intern at MRND LABS - Pune, MH', icon: const pw.IconData(0xe530), description: ''),
                    _Category(title: 'Projects'),
                    _Block(
                      title: 'ESP8266-Based Farming Monitoring System',
                      description: '• Implemented a real-time agricultural monitoring system using ESP8266.\n'
                          '• Enabled remote tracking of soil moisture, temperature, and humidity.\n'
                          '• Automated data collection to reduce water waste and increase crop yield.',
                      icon: const pw.IconData(0xe30d),
                    ),
                    _Block(
                      title: 'ESP8266-Based Parking Booking System with Smart Toll',
                      description: '• Developed a smart parking system with app connectivity and ESP8266.\n'
                          '• Integrated a user app for spot reservation and database for transactions.\n'
                          '• Added smart toll features to minimize traffic and automate payments.\n'
                          '• Implemented a web app to access the system through browsers.',
                      icon: const pw.IconData(0xe3f3),
                    ),
                    _Block(
                      title: 'Flutter Social Media App Development with Firebase',
                      description: '• Developed a social media app using Flutter, from initial concept to deployment.\n'
                          '• Integrated Firebase for real-time data handling, authentication, and storage.\n'
                          '• Implemented features like user profiles, posts, and direct messaging.',
                      icon: const pw.IconData(0xf0cf),
                    ),
                    _Block(
                      title: 'Predictive Maintenance Model Development',
                      description: '• Developed a machine learning model to predict machinery failures, enhancing maintenance efficiency.\n'
                          '• Utilized data preprocessing, exploratory analysis, and feature engineering to improve model accuracy.\n'
                          '• Implemented various algorithms to forecast equipment malfunctions, reducing operational downtime.',
                      icon: const pw.IconData(0xe0ca),
                    ),
                    _Category(title: 'Achievements'),
                    _Block(title: 'Winners of project competition (Pimpri Chinchwad College of Engineering And Research)', description: ''),
                    _Block(title: 'Runner-up in project competition (Pimpri Chinchwad Polytechnic College)', description: ''),
                    _Block(title: 'SIH internal hackathon selection', description: ''),
                    _Block(title: 'GeeksforGeeks Club Current Lead', description: ''),
                  ],
                ),
              ),
              pw.Partition(
                width: sep,
                child: pw.Column(
                  children: [
                    pw.Container(
                      height: pageTheme.pageFormat.availableHeight,
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: <pw.Widget>[
                          pw.ClipOval(
                            child: pw.Container(
                              width: 100,
                              height: 100,
                              color: lightGreen,
                              child: pw.Image(profileImage),
                            ),
                          ),
                          pw.BarcodeWidget(
                            data: 'Tanay Naphade',
                            width: 60,
                            height: 60,
                            barcode: pw.Barcode.qrCode(),
                            drawText: false,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  } catch (e) {
    print('Error in generating resume: $e');
  }

  return doc.save();
}

Future<pw.PageTheme> _myPageTheme(PdfPageFormat format) async {
  final bgShape = await rootBundle.loadString('assets/resume.svg');

  format = format.applyMargin(
      left: 2.0 * PdfPageFormat.cm,
      top: 4.0 * PdfPageFormat.cm,
      right: 2.0 * PdfPageFormat.cm,
      bottom: 2.0 * PdfPageFormat.cm);
  return pw.PageTheme(
    pageFormat: format,
    theme: pw.ThemeData.withFont(
      base: await PdfGoogleFonts.openSansRegular(),
      bold: await PdfGoogleFonts.openSansBold(),
      icons: await PdfGoogleFonts.materialIcons(),
    ),
    buildBackground: (pw.Context context) {
      return pw.FullPage(
        ignoreMargins: true,
        child: pw.Stack(
          children: [
            pw.Positioned(
              child: pw.SvgImage(svg: bgShape),
              left: 0,
              top: 0,
            ),
            pw.Positioned(
              child: pw.Transform.rotate(
                  angle: pi, child: pw.SvgImage(svg: bgShape)),
              right: 0,
              bottom: 0,
            ),
          ],
        ),
      );
    },
  );
}

class _Block extends pw.StatelessWidget {
  _Block({
    required this.title,
    required this.description,
    this.icon,
  });

  final String title;
  final String description;
  final pw.IconData? icon;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: <pw.Widget>[
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: <pw.Widget>[
            pw.Container(
              width: 6,
              height: 6,
              margin: const pw.EdgeInsets.only(top: 5.5, left: 2, right: 5),
              decoration: const pw.BoxDecoration(
                color: green,
                shape: pw.BoxShape.circle,
              ),
            ),
            pw.Text(title,
                style: pw.Theme.of(context)
                    .defaultTextStyle
                    .copyWith(fontWeight: pw.FontWeight.bold)),
            pw.Spacer(),
            if (icon != null) pw.Icon(icon!, color: lightGreen, size: 18),
          ],
        ),
        pw.Container(
          decoration: const pw.BoxDecoration(
              border: pw.Border(left: pw.BorderSide(color: green, width: 2))),
          padding: const pw.EdgeInsets.only(left: 10, top: 5, bottom: 5),
          margin: const pw.EdgeInsets.only(left: 5),
          child: pw.Text(
            description,
            style: pw.Theme.of(context).defaultTextStyle,
          ),
        ),
      ],
    );
  }
}

class _Category extends pw.StatelessWidget {
  _Category({required this.title});

  final String title;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      decoration: const pw.BoxDecoration(
        color: lightGreen,
        borderRadius: pw.BorderRadius.all(pw.Radius.circular(6)),
      ),
      margin: const pw.EdgeInsets.only(bottom: 10, top: 20),
      padding: const pw.EdgeInsets.fromLTRB(10, 4, 10, 4),
      child: pw.Text(
        title,
        textScaleFactor: 1.5,
      ),
    );
  }
}

class _UrlText extends pw.StatelessWidget {
  _UrlText(this.text, this.url);

  final String text;
  final String url;

  @override
  pw.Widget build(pw.Context context) {
    return pw.UrlLink(
      destination: url,
      child: pw.Text(text,
          style: const pw.TextStyle(
            decoration: pw.TextDecoration.underline,
            color: PdfColors.blue,
          )),
    );
  }
}
