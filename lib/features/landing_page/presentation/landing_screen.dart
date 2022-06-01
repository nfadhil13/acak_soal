import 'package:acak_soal/core/base_widgets/buttons/outlined_button.dart';
import 'package:acak_soal/core/base_widgets/buttons/primary_button.dart';
import 'package:acak_soal/core/base_widgets/progress_indicator/line_progress_indicator.dart';
import 'package:acak_soal/core/ext/ctx_ext.dart';
import 'package:acak_soal/core/style/color.dart';
import 'package:acak_soal/core/ext/text_style.dart';
import 'package:acak_soal/features/form/presentation/form/form_screen.dart';
import 'package:acak_soal/features/generate_template/presentation/generate_template.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../core/service_locator/injection_container.dart';

class LandingScreen extends StatelessWidget {
  static const routName = "/";
  LandingScreen({Key? key}) : super(key: key);
  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: screenshotController,
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Kelompok TA - 313",
                style: context.textTheme.headline1?.copyWith(
                    color: ColorTheme.primaryColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2),
              ),
              const SizedBox(height: 30),
              PrimaryButton("Mulai Acak", onPressed: () {
                Navigator.pushNamed(context, FormScreen.routeName);
              }),
              const SizedBox(height: 12),
              PrimaryButton("Generate Template", onPressed: () {
                GenerateTemplateScreen.showAsDialog(context);
              }),
              const SizedBox(height: 12),
              SecondaryButton(
                "About",
                padding:
                    const EdgeInsets.symmetric(horizontal: 42, vertical: 8),
                onPress: () async {
                  final screenShot = await screenshotController.capture(
                      pixelRatio: MediaQuery.of(context).devicePixelRatio,
                      delay: const Duration(seconds: 1));
                  final pdf = pw.Document();
                  if (screenShot == null) return;
                  pdf.addPage(
                    pw.Page(
                      pageFormat: PdfPageFormat.a4,
                      build: (context) {
                        return pw.Expanded(
                            child: pw.Image(pw.MemoryImage(screenShot),
                                fit: pw.BoxFit.contain));
                      },
                    ),
                  );
                  final dio = getIt<Dio>();
                  
                },
              ),
              const SizedBox(height: 15),
              Text(
                  "Created By:\nM Naufal Fadhil(181524016)\nRayhan Azka Anandhias Putra(181524016)",
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodySmall
                      ?.copyWith(color: ColorTheme.primaryColor, fontSize: 20)),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
