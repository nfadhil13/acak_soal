part of 'generate_template_cubit.dart';

@immutable
abstract class GenerateTemplateState {}

class GenerateTemplateIdleState extends GenerateTemplateState {}

class GenerateTemplateSuccess extends GenerateTemplateState {
  final String success;

  GenerateTemplateSuccess(this.success);
}


class GenerateTemplateLoadingState extends GenerateTemplateState {
  
}