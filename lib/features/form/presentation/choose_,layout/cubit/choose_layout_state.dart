part of 'choose_layout_cubit.dart';

@immutable
abstract class ChooselayoutcubitState {
  const ChooselayoutcubitState();
}

class ChooseLayoutIdle extends ChooselayoutcubitState {
  const ChooseLayoutIdle();
}

class ChooseLayoutLoading extends ChooselayoutcubitState {
  const ChooseLayoutLoading();
}

class ChooseLayoutSuccess extends ChooselayoutcubitState {
  final DataUjianFinal dataUjianFinal;

  const ChooseLayoutSuccess(this.dataUjianFinal);
}
