part of 'form_cubit.dart';

@immutable
abstract class FormCubitState {}

class FormIdle extends FormCubitState {}

class FormLoading extends FormCubitState {}

class FormSuccess extends FormCubitState {
  final DataInputUjian dataInputUjian;
  final Uint8List file;
  final List<LayoutRuangan> layoutRuangan;

  FormSuccess(this.dataInputUjian, this.file, this.layoutRuangan);
}
