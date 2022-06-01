import 'package:acak_soal/core/base_widgets/buttons/primary_button.dart';
import 'package:acak_soal/core/base_widgets/wrapper/form_wrapper.dart';
import 'package:acak_soal/core/ext/ctx_ext.dart';
import 'package:acak_soal/core/ext/list_ext.dart';
import 'package:acak_soal/core/service_locator/injection_container.dart';
import 'package:acak_soal/core/style/color.dart';
import 'package:acak_soal/features/common/domain/model/layout_ruangan.dart';
import 'package:acak_soal/features/form/presentation/choose_,layout/choose_layout_args.dart';
import 'package:acak_soal/features/form/presentation/result/result_screen.dart';
import 'package:acak_soal/features/landing_page/presentation/landing_screen.dart';
import 'package:easy_dialog/easy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base_widgets/loading/base_loading.dart';
import 'cubit/choose_layout_cubit.dart';

part './widgets/layout_table.dart';

class ChooseLayoutScreen extends StatelessWidget {
  static const routeName = "/choose-layout";

  const ChooseLayoutScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as ChooseLayoutArgs?;
    if (args != null) {
      return BlocProvider(
        create: (context) => getIt<ChooselayoutcubitCubit>(),
        child: _ChooseLayoutValid(args: args),
      );
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.popAndPushNamed(context, LandingScreen.routName);
    });
    return const SizedBox();
  }
}

class _ChooseLayoutValid extends StatelessWidget {
  final ChooseLayoutArgs args;
  const _ChooseLayoutValid({Key? key, required this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.primaryColor,
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            SingleChildScrollView(
                child: FormWrapper(
                    child: Column(
              children: [
                const SizedBox(height: 100),
                Text(
                  "Pilih Layout Kelas",
                  style: context.textTheme.headline2?.copyWith(
                      color: ColorTheme.primaryColor,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                const Text("Pilih salah satu layout pada tabel dibawah"),
                const Text("Dengan menekan tombol pilih"),
                const SizedBox(height: 100),
                _LayoutTable(chooseLayoutArgs: args),
                SizedBox(height: MediaQuery.of(context).size.height / 2)
              ],
            ))),
            BlocConsumer<ChooselayoutcubitCubit, ChooselayoutcubitState>(
              listener: (context, state) {
                if (state is ChooseLayoutSuccess) {
                  Navigator.pushNamed(context, ResultScreen.routeName,
                      arguments: state.dataUjianFinal);
                }
              },
              builder: (context, state) {
                return state is ChooseLayoutLoading
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
    );
  }
}
