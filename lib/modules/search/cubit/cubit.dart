

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/search_model.dart';
import 'package:shop/modules/search/cubit/states.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/network/end_points.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit <SearchStates>{
  SearchCubit() : super(SearchInitialStates());


  static SearchCubit get(context) => BlocProvider.of(context);



  SearchModel? model;
  void search(
  {
 required String? text,
}
      ){
    emit(SearchLoadingStates());
    DioHelper.
    postData(
        url: SEARCH,
        token: token,
        data: {
          'text' : text,
        },
    ).then((value) {
      print(value.data);
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccessStates());
    }).catchError((error){
      print(error.toString());
      emit(SearchErrorStates());
    });
  }

}