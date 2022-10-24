
import '../../../models/login_model.dart';

abstract class LogInStates {}

class InitialLogInStates extends LogInStates{}

class LoadingLogInStates extends LogInStates{}

class SuccessLogInStates extends LogInStates{
  late final LoginModel loginModel ;
  SuccessLogInStates({required this.loginModel});
}

class ErrorLogInStates extends LogInStates{
  late final String error;
  ErrorLogInStates(this.error);
}

class ChangePasswordVisibilityLogInState extends LogInStates{}