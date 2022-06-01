part of 'get_result_to_email_cubit.dart';

@immutable
abstract class GetResultToEmailState {
  T when<T>(
      {required T Function(GetResultToEmailIdleState state) onIdle,
      required T Function(GetResultToEmailGeneratingPDF state) onGeneratingPDF,
      required T Function(GetResultToEmailRequestingState state) onEmailRequest,
      required T Function(GetResultToEmailSuccessState state) onSuccesss}) {
    final value = this;
    if (value is GetResultToEmailGeneratingPDF) return onGeneratingPDF(value);
    if (value is GetResultToEmailRequestingState) return onEmailRequest(value);
    if (value is GetResultToEmailSuccessState) return onSuccesss(value);
    return onIdle(value as GetResultToEmailIdleState);
  }
}

class GetResultToEmailIdleState extends GetResultToEmailState {}

class GetResultToEmailGeneratingPDF extends GetResultToEmailState {}

class GetResultToEmailRequestingState extends GetResultToEmailState {}

class GetResultToEmailSuccessState extends GetResultToEmailState {}
