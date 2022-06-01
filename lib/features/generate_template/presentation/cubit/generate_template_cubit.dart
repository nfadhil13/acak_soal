import 'package:acak_soal/features/generate_template/domain/repositories/generate_template_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'generate_template_state.dart';

class GenerateTemplateCubit extends Cubit<GenerateTemplateState> {
  final GenerateTemplateRepository _repo;
  GenerateTemplateCubit(this._repo) : super(GenerateTemplateIdleState());

  void submit(String email, int numberOfSoal) async {
    emit(GenerateTemplateLoadingState());
    final result =
        await _repo.generateTemplate(email: email, numberOfSoal: numberOfSoal);
    result.whenWithResult(success: (data) {
      emit(GenerateTemplateSuccess(
          "Template akan dikirim ke $email, silahkan cek email anda"));
    }, error: (error) {
      emit(GenerateTemplateIdleState());
    });
  }
}
