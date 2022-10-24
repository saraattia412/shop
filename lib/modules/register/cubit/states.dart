
import '../../../models/login_model.dart';

abstract class SignUpStates {}

class InitialSignUpStates extends SignUpStates{}

class LoadingSignUpStates extends SignUpStates{}

class SuccessSignUpStates extends SignUpStates{
  late final LoginModel loginModel ;
  SuccessSignUpStates({required this.loginModel});
}

class ErrorSignUpStates extends SignUpStates{
  late final error;
  late final LoginModel loginModel;
  ErrorSignUpStates({required this.loginModel,required this.error});
}

class ChangePasswordVisibilitySignUpState extends SignUpStates{}