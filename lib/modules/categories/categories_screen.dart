import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/categories_model.dart';
import 'package:shop/shared/cubit/cubit.dart';
import 'package:shop/shared/cubit/states.dart';

import '../../shared/components/line.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        return ListView.separated(
          itemBuilder: (context,index) => buildCategoriesItem(ShopCubit.get(context).categoriesModel!.data.data[index]),
          separatorBuilder: (context,index) => myDivider(),
          itemCount: ShopCubit.get(context).categoriesModel!.data.data.length,
        );
      },
    );
  }



  Widget buildCategoriesItem(DataModel model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:  [
        Image(
          image: NetworkImage(model.image),
          width: 80,
          height: 80,
        ),
        const SizedBox(
          width : 20,
        ),
        Text(
         model.name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        const Icon(
          Icons.arrow_forward_ios,
        ),
      ],
    ),
  );
}
