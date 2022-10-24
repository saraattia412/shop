import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/shared/components/navigator.dart';
import 'package:shop/shared/cubit/cubit.dart';
import 'package:shop/shared/cubit/states.dart';
import 'package:shop/shared/styles/color.dart';

import '../../shared/components/line.dart';
import '../address/address_screen.dart';
import '../profile/profile_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {

        var model = ShopCubit.get(context).loginModel;

        return Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  model!.data!.name!,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              myDivider(),
              SizedBox(height: 20,),
              design(context, Icons.person, 'Profile', ProfileScreen(),defaultColor),
              design(context, Icons.home_outlined, 'Address', AddressScreen(), Colors.purple),
            ],


          ),
        );
      },

    );
  }


  Widget design(context,icon,title,screen,color) =>  Padding(
    padding: const EdgeInsetsDirectional.only(
      start: 15,
      bottom: 20,
    ),
    child: Row(
      children: [
        CircleAvatar(
          radius: 20.0,
          backgroundColor: color,
          child: Icon(
            icon,
            size: 30,
          ),
        ),
        SizedBox(width: 10,),
        TextButton(onPressed:(){
          navigateTo(context,screen);
        },
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )
        ),
      ],
    ),
  );
}
