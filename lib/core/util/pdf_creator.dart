import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PDFCreator {
  final ScreenshotController _screenshotController;

  const PDFCreator(this._screenshotController);
  Future<Uint8List> generatePDF(
      List<Widget> pages, BuildContext context) async {
    final pdf = pw.Document();
    for (var page in pages) {
      final screenShoot = await _screenshotController.captureFromWidget(page,
          context: context,
          pixelRatio: MediaQuery.of(context).devicePixelRatio,
          delay: const Duration(milliseconds: 10));
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (context) {
            return pw.Expanded(
                child: pw.Image(pw.MemoryImage(screenShoot),
                    alignment: pw.Alignment.center, fit: pw.BoxFit.contain));
          },
        ),
      );
    }
    return await pdf.save();
  }
}
