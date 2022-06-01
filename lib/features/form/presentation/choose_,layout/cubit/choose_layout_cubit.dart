import 'package:acak_soal/features/common/domain/model/data_ujian_final.dart';
import 'package:acak_soal/features/common/domain/model/layout_ruangan.dart';
import 'package:acak_soal/features/common/domain/repositories/pengacakan_repository.dart';
import 'package:acak_soal/features/form/presentation/choose_,layout/choose_layout_args.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'choose_layout_state.dart';

class ChooselayoutcubitCubit extends Cubit<ChooselayoutcubitState> {
  final PengacakanRepository _pengacakanRepository;
  ChooselayoutcubitCubit(this._pengacakanRepository)
      : super(const ChooseLayoutIdle());

  void startAcakSoal(
      ChooseLayoutArgs chooseLayoutArgs, LayoutRuangan layoutRuangan) async {
    emit(const ChooseLayoutLoading());
    final execute = await _pengacakanRepository.startAcak(
        dataInputUjian: chooseLayoutArgs.dataInputUjian,
        dataSoal: chooseLayoutArgs.file,
        layoutRuangan: layoutRuangan);
    execute.whenWithResult(success: (data) {
      emit(ChooseLayoutSuccess(data));
    }, error: (error) {
      print(error.exception.message);
      emit(const ChooseLayoutIdle());
    });
  }
}
