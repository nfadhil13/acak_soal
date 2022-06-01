import 'dart:typed_data';

import 'package:acak_soal/features/common/domain/model/data_input_ujian.dart';
import 'package:acak_soal/features/common/domain/model/data_ruangan.dart';
import 'package:acak_soal/features/common/domain/model/layout_ruangan.dart';
import 'package:acak_soal/features/common/domain/repositories/pengacakan_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'form_state.dart';

class FormCubit extends Cubit<FormCubitState> {
  final PengacakanRepository _pengacakanRepository;
  FormCubit(this._pengacakanRepository) : super(FormIdle());

  void submit(
      {required DataInputUjian dataInputUjian,
      required Uint8List dataSoal}) async {
    emit(FormLoading());
    final transaction = await _pengacakanRepository.getOptimumLayoutRuangan(
        dataInputUjian: dataInputUjian, dataSoal: dataSoal);
    transaction.whenWithResult(success: (data) {
      emit(FormSuccess(dataInputUjian, dataSoal, data));
    }, error: (error) {
      emit(FormIdle());
    });
  }
}
