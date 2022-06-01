import 'package:acak_soal/core/base_widgets/loading/base_loading.dart';
import 'package:acak_soal/core/ext/ctx_ext.dart';
import 'package:acak_soal/core/service_locator/injection_container.dart';
import 'package:acak_soal/features/generate_template/presentation/cubit/generate_template_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base_widgets/buttons/outlined_button.dart';
import '../../../core/base_widgets/buttons/primary_button.dart';
import '../../../core/base_widgets/form/base_text_field.dart';
import '../../../core/style/color.dart';
import '../../../core/ext/string_ext.dart';

part 'widgets/form.dart';

class GenerateTemplateScreen extends StatelessWidget {
  static const routeName = "/generate-template";
  const GenerateTemplateScreen({Key? key}) : super(key: key);

  static void showAsDialog(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final dialogWidth = width < 550.0 ? width : 550.0;
    showDialog(
        barrierColor: Colors.black.withOpacity(0.2),
        context: context,
        barrierDismissible: false,
        builder: (ctx) => Dialog(
              child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  width: dialogWidth,
                  height: 500,
                  child: const GenerateTemplateScreen()),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => getIt<GenerateTemplateCubit>(),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: BlocBuilder<GenerateTemplateCubit, GenerateTemplateState>(
                builder: (context, state) {
                  return state is GenerateTemplateSuccess
                      ? _SuccessDialogContent(meesage: state.success)
                      : const _Form();
                },
              ),
            ),
            BlocBuilder<GenerateTemplateCubit, GenerateTemplateState>(
              builder: (context, state) {
                if (state is GenerateTemplateLoadingState) {
                  return Container(
                      color: Colors.black.withOpacity(0.2),
                      alignment: Alignment.center,
                      child: const BaseLoading());
                }
                return const SizedBox();
              },
            )
          ],
        ));
  }
}

class _SuccessDialogContent extends StatelessWidget {
  final String meesage;
  const _SuccessDialogContent({Key? key, required this.meesage})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              meesage,
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
