// ignore_for_file: must_be_immutable, unnecessary_null_comparison



import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/shared/components/default_button.dart';
import 'package:shop/shared/cubit/cubit.dart';
import 'package:shop/shared/cubit/states.dart';
import '../../shared/components/form_field.dart';
import '../../shared/components/sign_out.dart';



class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
    var formKey =GlobalKey<FormState>();
     var emailController =TextEditingController();
     var nameController = TextEditingController();
     var phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {




    return BlocConsumer<ShopCubit,ShopStates>(
      listener: ( context, state) {},
      builder: ( context, state) {

        var model = ShopCubit.get(context).loginModel;
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;


        return Scaffold(
          appBar: AppBar(
            title: Text('profile'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ConditionalBuilder(
              condition: ShopCubit.get(context).loginModel  != null,
              builder: (context) =>SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if(state is ShopUpdateLoadingState)
                        LinearProgressIndicator(),
                      const SizedBox(
                        height: 20,
                      ),
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
                      const SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          controller: emailController,
                          type:TextInputType.emailAddress ,
                          validator:(value){
                            if (value!.isEmpty){
                              return 'email must not be null';
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
                      const SizedBox(
                        height: 20,
                      ),
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

                      defaultButton(function: (){

                        if(formKey.currentState!.validate()){

                          ShopCubit.get(context).updateUserData(
                            email: emailController.text,
                            phone: phoneController.text,
                            name: nameController.text,

                          );
                        }


                      },
                        text: 'Update',
                        background: Colors.blueGrey,
                      ),
                      const SizedBox(height: 20,),

                      defaultButton(function: (){
                        signOut(context);
                      },
                        text: 'Logout',
                        background: Colors.blueGrey,
                      ),

                    ],
                  ),
                ),
              ),
              fallback: (BuildContext context) => const Center(child: CircularProgressIndicator()) ,

            ),
          ),
        );
      },

    );





  }






}

