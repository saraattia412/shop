// ignore_for_file: prefer_const_constructors

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop/modules/search/search_screen.dart';
import 'package:shop/shared/components/navigator.dart';
import 'package:shop/shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';


class ShopLayout extends StatelessWidget {
   const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {

        var cubit = ShopCubit.get(context);

        return Scaffold(
          appBar: AppBar(
              title: const Text(
                'Market',
              ),
            actions: [
              IconButton(onPressed: (){
                navigateTo(context, SearchScreen());
              }, icon: Icon(
                Icons.search
              ))
            ],
          ),

            body: cubit.bottomScreens[cubit.currentIndex],



            bottomNavigationBar: ConvexAppBar(
              activeColor: Colors.blueGrey,
              backgroundColor: HexColor('#ffb3ec'),
              height: 60,
              style: TabStyle.flip,
              elevation: -1,
              onTap: (index){
                cubit.changeBottom(index);
              },
              items: const [
                TabItem(icon: Icons.home, title: 'Home'),
                TabItem(icon: Icons.apps, title: 'Categories'),
                TabItem(icon: Icons.favorite, title: 'Favorites'),
                TabItem(icon: Icons.settings, title: 'Setting'),
              ],

            ),
        );
      },

    );
  }
}
