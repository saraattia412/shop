// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/register/cubit/states.dart';
import 'package:shop/shared/network/end_points.dart';

import '../../../models/login_model.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../../shared/components/constants.dart';




class SignUpCubit extends Cubit<SignUpStates>{
  SignUpCubit() : super(InitialSignUpStates());

  static SignUpCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel ;


  void userLogin({
    required String name,
    required String email,
    required String phone,
    required String password,
  }){
    emit(LoadingSignUpStates());
    DioHelper.postData(
      url: REGISTER,
      data: {            //map:key&&value
        'email':email,
        'name' :name,
        'phone' : phone,
        'password':password,
      },
    ).then((value)  {
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel!.status);
      token = loginModel!.data!.token!;
      emit(SuccessSignUpStates(loginModel: loginModel!));
    }).catchError((error){
      print(error.toString());
      emit(ErrorSignUpStates(loginModel: loginModel!, error: loginModel!.message!));
    });
  }


  IconData suffix=Icons.visibility_off_outlined;
  bool isPassword=true;

  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix=isPassword ? Icons.visibility_off_outlined  : Icons.visibility_outlined;
    emit(ChangePasswordVisibilitySignUpState());

  }

}