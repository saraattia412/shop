// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/login/cubit/states.dart';

import '../../../models/login_model.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';

class LogInCubit extends Cubit<LogInStates>{
  LogInCubit() : super(InitialLogInStates());

  static LogInCubit get(context) => BlocProvider.of(context);

  late LoginModel loginModel ;

  void userLogin({
    required String email,
    required String password,
  }){
    emit(LoadingLogInStates());
    DioHelper.postData(
      url: LOGIN,
      data:
      {
        'email':email,
        'password': password,
      },
    ).then((value)
    {
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel.status);
      print(loginModel.message);
      print(loginModel.data!.token);
      token = loginModel.data!.token!;
      emit(SuccessLogInStates( loginModel: loginModel));
    }).catchError((error){
      print(error.toString());
      emit(ErrorLogInStates(error.toString()));
    });
  }





  IconData suffix=Icons.visibility_off_outlined;
  bool isPassword=true;

  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix=isPassword ? Icons.visibility_off_outlined  : Icons.visibility_outlined;
    emit(ChangePasswordVisibilityLogInState());

  }

}