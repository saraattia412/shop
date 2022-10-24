// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/shared/cubit/cubit.dart';
import 'package:shop/shared/cubit/states.dart';

import '../../shared/styles/color.dart';


class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        return  ConditionalBuilder(
          condition: ShopCubit.get(context).favoriteModel?.data?.data != null,
          builder:(context)=> ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context , index)=>buildFavoritesItem(
                  ShopCubit.get(context).favoriteModel!.data!.data![index].product!,context),
              separatorBuilder: (context , index)=> const Divider(),
              itemCount: ShopCubit.get(context).favoriteModel!.data!.data!.length
          ),
          fallback:(context)=> const Center(child: CircularProgressIndicator(),),
        );
      },

    );
  }






  Widget buildFavoritesItem(model,context ,{bool hasOldPrice = true})=>Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: SizedBox(
      height: 120,
      child: Row(
        mainAxisAlignment:MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            height: 120,
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image!),
                  width: 120,
                  height: 120,
                ),
                if(model.discount !=0 && hasOldPrice)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    color: Colors.red,

                    child: Text('${model.discount} OFF', style: const TextStyle(color: Colors.white,fontSize: 12.0) ),
                  )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name!,
                    maxLines: 2,
                    overflow:TextOverflow.ellipsis,
                    style: const TextStyle(
                        height: 1.1,
                        fontSize: 14.0
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.price!} \$',
                        maxLines: 2,
                        overflow:TextOverflow.ellipsis,
                        style:  TextStyle(
                          fontSize: 12.0,
                          color: defaultColor,

                        ),
                      ),
                      const SizedBox(width: 5,),
                      if(model.discount !=0 && hasOldPrice)
                        Text(
                          '${model.oldPrice} \$',
                          maxLines: 2,
                          overflow:TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,


                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: (){
                          ShopCubit.get(context).changeFavorites(model.id!);
                        },
                        icon: ShopCubit.get(context).favorites[model.id]!
                        ? const Icon(Icons.favorite,size: 25,color: Colors.red,)
                            : const Icon(Icons.favorite_border,size: 25,),

                        //  constraints: const BoxConstraints(),
                        // padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
