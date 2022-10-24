// ignore_for_file: unnecessary_null_comparison, avoid_print



import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/categories_model.dart';
import 'package:shop/models/home_model.dart';
import 'package:shop/shared/components/toast_package.dart';
import 'package:shop/shared/cubit/cubit.dart';
import 'package:shop/shared/styles/color.dart';

import '../../shared/cubit/states.dart';


class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (BuildContext context, state) {
        if(state is ShopChangeFavoritesSUCCESSState){
          if(!state.model.status!){
            showToast(text:state.model.message! , state: ToastStates.ERROR);
          }
        }
        if(state is SuccessAddCartsStates){
          print(state.cardModel.message);
          if(state.cardModel.status!){
            showToast(
                text: 'Added Successfully',
                state: ToastStates.SUCCESS,
            );
          }else{
            showToast(
              text: state.cardModel.message!,
              state: ToastStates.ERROR,
            );
          }
        }
      },
      builder: (BuildContext context, Object? state) {
        return ConditionalBuilder(
            condition:  ShopCubit.get(context).homeModel != null
                && ShopCubit.get(context).categoriesModel != null,
            builder: (context) => productsBuilder(ShopCubit.get(context).homeModel!,
                ShopCubit.get(context).categoriesModel! , context),
            fallback:(context) => const Center(child: CircularProgressIndicator())
        );
      },
    );
  }


  Widget productsBuilder(HomeModel model,CategoriesModel categoriesModel ,context) => SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CarouselSlider(
              items: model.data!.banners.map((e) =>  Image(
                image: NetworkImage('${e.image}'),
                width: double.infinity,
                fit: BoxFit.cover,
              ),).toList(),
              options: CarouselOptions(
                height: 200.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1.0
              )),
        ),
        const SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Categories',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800
                ),
              ),
              const SizedBox(height: 10,),
              SizedBox(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context , index) => buildCategories(categoriesModel.data.data[index]),
                  separatorBuilder:(context , index ) => const SizedBox(width: 10,),
                  itemCount:categoriesModel.data.data.length,
                ),
              ),
              const SizedBox(height: 20,),
              const Text(
                'New Products',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10,),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            childAspectRatio: 1/1.9,//width/height
            children: List.generate(
                model.data!.products.length,
                    (index) => buildGridProducts(model.data!.products[index] , context)
                       ),
          ),
        ),
      ],
    ),
  );



  Widget buildCategories(DataModel model) =>   Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children:  [
       Image(
          image: NetworkImage(model.image),
        height: 100,
        width: 100,
        fit: BoxFit.cover
      ),
      Container(
        color: Colors.black.withOpacity(.8),
        width: 100,
        child:  Text(
          model.name,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white
          ),
        ),
      ),
    ],
  );

  Widget buildGridProducts(ProductModel model , context) => Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
                image: NetworkImage(model.image!),
              width: double.infinity,
              height: 200,
            ),
            if(model.discount != 0)
              Container(
              color: Colors.red,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5,),
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.white
                  ),
                ),
              ),
            ),
          ],
        ),
       Padding(
         padding: const EdgeInsets.all(12.0),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,

           children: [
             Text(
               model.name!,
               maxLines: 2,
               overflow: TextOverflow.ellipsis,
               style: const TextStyle(
                   fontSize: 14,
                   height: 1.3
               ),
             ),
             Row(
               children: [
                 Text(
                   ' ${model.price.round()}',
                   style:  TextStyle(
                       fontSize: 12,
                       color: defaultColor
                   ),
                 ),
                 const SizedBox(width: 5,),
                 if(model.discount != 0 )
                   Text(
                   ' ${model.old_price.round()}',
                   style: const TextStyle(
                     fontSize: 10,
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
             Container(
               decoration: BoxDecoration(
                   color:defaultColor,
                   borderRadius: BorderRadius.circular(15)
               ),
               child: TextButton(
                   onPressed: (){
                     ShopCubit.get(context).addCarts( id: model.id!);
                   }, child: Text(
                 'Buy Now',
               )
               ),
             )

           ],
         ),
       )

      ],
    ),
  );


  

}
