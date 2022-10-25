// ignore_for_file: avoid_print, must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/register/cubit/states.dart';

import '../../layout/shop_layout.dart';
import '../../shared/components/constants.dart';
import '../../shared/components/default_button.dart';
import '../../shared/components/form_field.dart';
import '../../shared/components/navigate_and_finish.dart';
import '../../shared/components/toast_package.dart';
import '../../shared/network/local/cache_helper.dart';
import 'cubit/cubit.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({Key? key}) : super(key: key);
  var formKey =GlobalKey<FormState>();
   var emailController =TextEditingController();
   var passwordController = TextEditingController();
   var phoneController = TextEditingController();
   var nameController = TextEditingController();

   @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit , SignUpStates>(
        listener: (BuildContext context, state) {

          if(state is SuccessSignUpStates) {
            if (state.loginModel.status!) {
              print(state.loginModel.data!.token);
              CacheHelper.saveData(
                  key: 'token', value: state.loginModel.data!.token).then((value) {
                token = state.loginModel.data!.token       ;
                navigateAndFinish(context,  const ShopLayout());
                showToast(text: state.loginModel.message!, state: ToastStates.SUCCESS);
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
                          'REGISTER',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),

                        ),
                        const Text(
                          'Register now to browse our hot offers ',
                          style: TextStyle(
                            color: Colors.grey,
                          ),

                        ),
                        const SizedBox(height: 30,),

                        defaultFormField(
                          controller: nameController,
                          type:TextInputType.name ,
                          validator:(value){
                            if (value!.isEmpty){
                              return 'name must not be null';
                            }
                            return null;
                          } ,
                          label:'Name' ,
                          prefix: Icons.person,
                          onSubmit: (value){
                            TextInputAction.done;
                          },
                            onTap: (){
                              print(nameController);
                            }
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
                          onTap: (){
                            print(emailController);
                          }

                        ),
                        const SizedBox(height: 30,),
                        defaultFormField(
                          controller: phoneController,
                          type:TextInputType.phone ,
                          validator:(value){
                            if (value!.isEmpty){
                              return 'phone number must not be null';
                            }
                            return null;
                          } ,
                          label:'Phone Number' ,
                          prefix: Icons.phone_android,
                          onSubmit: (value){
                            TextInputAction.done;
                          },
                            onTap: (){
                              print(phoneController);
                            }

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
                          isPassword: SignUpCubit.get(context).isPassword,
                          suffix: SignUpCubit.get(context).suffix,
                          suffixPressed: (){//الدوسه
                            SignUpCubit.get(context).changePasswordVisibility();
                          },
                          onSubmit: (value){
                            TextInputAction.done;
                            if(formKey.currentState!.validate()){

                            }
                          },
                            onTap: (){
                              print(passwordController);
                            }
                        ),
                        const SizedBox(height: 30,),
                        ConditionalBuilder(
                          condition: state is! LoadingSignUpStates,
                          builder: (BuildContext context) => defaultButton(
                            function: (){
                              if(formKey.currentState!.validate()){
                                SignUpCubit.get(context)
                                    .userLogin(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                    password: passwordController.text
                                );
                              }

                              },

                            text: 'sign up',
                            isUpperCase: true,
                            background: Colors.blueGrey,
                          ),
                          fallback:(context) => const Center(child: CircularProgressIndicator()),
                        ),
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
