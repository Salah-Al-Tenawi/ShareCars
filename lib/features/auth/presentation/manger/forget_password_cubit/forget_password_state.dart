part of 'forget_password_cubit.dart';

sealed class ForgetPasswordState extends Equatable {
  const ForgetPasswordState();

  @override
  List<Object> get props => [];
}

final class ForgetPasswordInitial extends ForgetPasswordState {}

final class ForgetPasswordLoading extends ForgetPasswordState {}

final class ForgetPasswordErorr extends ForgetPasswordState {
   final String message;

  const ForgetPasswordErorr({required this.message});
}
final class ForgetPasswordSuccsess extends ForgetPasswordState {
 
}
