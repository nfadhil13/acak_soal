import 'dart:typed_data';

import 'package:acak_soal/core/base_widgets/buttons/outlined_button.dart';
import 'package:acak_soal/core/base_widgets/buttons/primary_button.dart';
import 'package:acak_soal/core/base_widgets/buttons/upload_button.dart';
import 'package:acak_soal/core/base_widgets/form/base_text_field.dart';
import 'package:acak_soal/core/base_widgets/loading/base_loading.dart';
import 'package:acak_soal/core/base_widgets/wrapper/form_wrapper.dart';
import 'package:acak_soal/core/ext/ctx_ext.dart';
import 'package:acak_soal/core/service_locator/injection_container.dart';
import 'package:acak_soal/core/style/color.dart';
import 'package:acak_soal/features/common/domain/model/data_input_ujian.dart';
import 'package:acak_soal/features/form/presentation/choose_,layout/choose_layout_args.dart';
import 'package:acak_soal/features/form/presentation/choose_,layout/choose_layout_screen.dart';
import 'package:easy_dialog/easy_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:acak_soal/core/ext/string_ext.dart';

import '../../../generate_template/presentation/generate_template.dart';
import 'cubit/form_cubit.dart';
part './widgets/form.dart';

class FormScreen extends StatelessWidget {
  static const routeName = "/form-screen";
  const FormScreen({Key? key}) : super(key: key);

  void showDialog(BuildContext context) {
    EasyDialog(
        title: const Text(""),
        description: const Text(""),
        height: 200,
        contentList: [
          const Text(
            "Gagal Mendapatkan Layout Kelas",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            textScaleFactor: 1.2,
          ),
          const SizedBox(height: 10),
          const Text(
            """Ruangan terlalu kecil untuk jumlah peserta yang mengikuti ujian""",
            textScaleFactor: 1.1,
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "OK",
                    textScaleFactor: 1.2,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          )
        ]).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<FormCubit>(),
      child: Scaffold(
        backgroundColor: ColorTheme.primaryColor,
        body: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              const SingleChildScrollView(child: FormWrapper(child: _Form())),
              BlocConsumer<FormCubit, FormCubitState>(
                listener: (context, state) {
                  if (state is FormSuccess) {
                    if (state.layoutRuangan.isEmpty) {
                      showDialog(context);
                      return;
                    }
                    Navigator.pushNamed(context, ChooseLayoutScreen.routeName,
                        arguments: ChooseLayoutArgs(state.dataInputUjian,
                            state.file, state.layoutRuangan));
                  }
                },
                builder: (context, state) {
                  return state is FormLoading
                      ? Positioned.fill(
                          child: Container(
                          alignment: Alignment.center,
                          color: Colors.black.withOpacity(0.5),
                          child: const BaseLoading(),
                        ))
                      : const SizedBox();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
