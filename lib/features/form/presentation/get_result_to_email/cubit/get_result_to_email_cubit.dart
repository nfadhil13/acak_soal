import 'package:acak_soal/core/util/pdf_creator.dart';
import 'package:acak_soal/features/common/domain/model/data_ujian_final.dart';
import 'package:acak_soal/features/common/domain/repositories/pengacakan_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'get_result_to_email_state.dart';

class GetResultToEmailCubit extends Cubit<GetResultToEmailState> {
  final PDFCreator _pdfCreator;
  final PengacakanRepository _repo;

  GetResultToEmailCubit(this._pdfCreator, this._repo)
      : super(GetResultToEmailIdleState());

  void submit(String email, String soalPath, BuildContext context,List<Widget> pages) async {
    emit(GetResultToEmailGeneratingPDF());
    final pdf = await _pdfCreator.generatePDF(pages, context);
    emit(GetResultToEmailRequestingState());
    await _repo.sentEmail(email: email, soalPath: soalPath, pdf: pdf);
    emit(GetResultToEmailSuccessState());
  }
}
