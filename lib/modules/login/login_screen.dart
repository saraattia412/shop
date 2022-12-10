// ignore_for_file: avoid_print, must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop/shared/components/constants.dart';

import '../../layout/shop_layout.dart';
import '../../shared/components/default_button.dart';
import '../../shared/components/form_field.dart';
import '../../shared/components/navigate_and_finish.dart';
import '../../shared/components/navigator.dart';
import '../../shared/components/toast_package.dart';
import '../../shared/network/local/cache_helper.dart';
import '../register/register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class LogInScreen extends StatelessWidget {
   LogInScreen({Key? key}) : super(key: key);
   var formKey =GlobalKey<FormState>();

   var emailController =TextEditingController();
   var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {


    return BlocProvider(
      create: (BuildContext context) => LogInCubit(),
      child: BlocConsumer<LogInCubit,LogInStates>(
        listener: (BuildContext context, state) {
      if(state is SuccessLogInStates) {
        if (state.loginModel.status!) {
          print(state.loginModel.data!.token);
          CacheHelper.saveData(
              key: 'token', value: state.loginModel.data!.token).then((value) {
                showToast(text: state.loginModel.message!, state: ToastStates.SUCCESS);
           })
            .then((value) {
              token = state.loginModel.data!.token       ;
              navigateAndFinish(context,  const ShopLayout());
          });
        } else {
          showToast(
            text: state.loginModel.message!,
            state: ToastStates.ERROR,
          );
        }
      }
        },
        builder: (BuildContext context, Object? state) {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        const Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),

                        ),
                        const Text(
                          'Login now to browse our hot offers ',
                          style: TextStyle(
                            color: Colors.grey,
                          ),

                        ),
                        const SizedBox(height: 30,),
                        defaultFormField(
                          controller: emailController,
                          type:TextInputType.emailAddress ,
                          validator:(value){
                            if (value!.isEmpty){
                              return 'please enter your email address';
                            }
                            return null;
                          } ,
                          label:'Email Address' ,
                          prefix: Icons.email_outlined,
                          onSubmit: (value){
                            TextInputAction.done;
                          },

                        ),
                        const SizedBox(height: 20,),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validator: ( value){
                            if (value!.isEmpty){
                              return 'Password Is Too Short';
                            }
                            return null;
                          } ,
                          label: 'Password',
                          prefix: Icons.lock_outlined,
                          isPassword: LogInCubit.get(context).isPassword,
                          suffix: LogInCubit.get(context).suffix,
                          suffixPressed: (){//الدوسه
                            LogInCubit.get(context).changePasswordVisibility();
                          },
                          onSubmit: (value){
                            TextInputAction.done;
                            if(formKey.currentState!.validate()){
                              LogInCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 30,),
                        ConditionalBuilder(
                          condition: state is! LoadingLogInStates,
                          builder: (BuildContext context) => defaultButton(
                            function: (){
                              if(formKey.currentState!.validate()){
                                LogInCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text
                                );
                              }

                            },
                            text: 'login',
                            isUpperCase: true,
                            background: Colors.blueGrey,
                          ),
                          fallback:(context) => const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                            const Text(
                                'don\'t have account?  '
                            ),
                            TextButton(onPressed: (){
                              navigateTo(context,  RegisterScreen());
                            }, child:  Text(
                                'register now!',
                              style: TextStyle(
                                color: HexColor('#cc0099')
                              ),
                            ),)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),

          );
        },
      ),
    );
  }
}
