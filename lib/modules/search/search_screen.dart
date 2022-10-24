// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/search/cubit/states.dart';
import 'package:shop/shared/components/form_field.dart';

import '../../shared/styles/color.dart';
import 'cubit/cubit.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Search'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    defaultFormField(
                        controller: searchController,
                        type: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty)
                            return 'What do you want to search for ?';
                          return null;
                        },
                        label: 'Search',
                        prefix: Icons.search,
                        onTap: () {
                          print(searchController);
                        },
                      onSubmit: (String text){
                          SearchCubit.get(context)
                              .search(text: text);
                      }
                        ),
                    const SizedBox(height: 10,),
                    if(state is SearchLoadingStates)
                      const LinearProgressIndicator(),
                    const SizedBox(height: 10,),
                    if(state is SearchSuccessStates)
                      Expanded(
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context , index)=> buildSearch(SearchCubit.get(context)
                                .model!.data!.data![index],context,hasOldPrice: false),
                            separatorBuilder: (context , index)=> const Divider(),
                            itemCount: SearchCubit.get(context).model!.data!.data!.length
                        ),
                      ),


                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildSearch(model,context ,{bool hasOldPrice = true})=>Padding(
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
