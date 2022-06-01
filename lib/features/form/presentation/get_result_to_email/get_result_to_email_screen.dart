import 'package:acak_soal/core/base_widgets/loading/base_loading.dart';
import 'package:acak_soal/core/base_widgets/loading/text_loading.dart';
import 'package:acak_soal/core/ext/ctx_ext.dart';
import 'package:acak_soal/core/ext/string_ext.dart';
import 'package:acak_soal/features/form/presentation/get_result_to_email/cubit/get_result_to_email_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base_widgets/buttons/outlined_button.dart';
import '../../../../core/base_widgets/buttons/primary_button.dart';
import '../../../../core/base_widgets/form/base_text_field.dart';
import '../../../../core/service_locator/injection_container.dart';
import '../../../../core/style/color.dart';

part 'widgets/form.dart';

class GetResultToEmailScreen extends StatelessWidget {
  final BuildContext parentContext;
  final List<Widget> widget;
  final String soalPath;
  const GetResultToEmailScreen({Key? key, required this.parentContext, required this.widget, required this.soalPath}) : super(key: key);

  static void showAsDialog(BuildContext context,List<Widget> pdfPages, String soalPath) {
    
    final width = MediaQuery.of(context).size.width;
    final dialogWidth = width < 550.0 ? width : 550.0;
    showDialog(
        barrierColor: Colors.black.withOpacity(0.2),
        context: context,   
        barrierDismissible: false,
        builder: (ctx) => Dialog(
              child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  width: dialogWidth,
                  height: 400,
                  child:  GetResultToEmailScreen(parentContext: context, soalPath: soalPath, widget: pdfPages)),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => getIt<GetResultToEmailCubit>(),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: BlocBuilder<GetResultToEmailCubit, GetResultToEmailState>(
                  builder: (context, state) => state.when(
                      onIdle: (state) =>  _Form(parentContext: parentContext, soalPath: soalPath, widget: widget),
                      onGeneratingPDF: (state) => const _LoadingContent(message: "Generating PDF"),
                      onEmailRequest: (state) => const _LoadingContent(message: "Sending Email To Your PDF"),
                      onSuccesss: (state) => const _SuccessDialogContent())),
            ),
          ],
        ));
  }
}

class _LoadingContent extends StatelessWidget {
  final String message;
  const _LoadingContent({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            const SizedBox(child: BaseLoading()),
            const SizedBox(height: 10,
            ),
            LoadingText(
              message,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
}

class _SuccessDialogContent extends StatelessWidget {
  const _SuccessDialogContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Hasil Template dalam bentuk PDF Sudah dikirim ke Email Anda",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 35),
            PrimaryButton(
              "Ok",
              onPressed: (() {
                Navigator.of(context).pop();
              }),
            )
          ],
        ),
      );
}
