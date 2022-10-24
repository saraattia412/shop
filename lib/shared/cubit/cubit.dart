// ignore_for_file: annotate_overrides,, avoid_print, avoid_function_literals_in_foreach_calls



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/categories_model.dart';
import 'package:shop/models/favorites_model.dart';
import 'package:shop/models/home_model.dart';
import 'package:shop/shared/cubit/states.dart';
import 'package:shop/shared/network/end_points.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';

import '../../models/cartsmodel.dart';
import '../../models/change_favorites_model.dart';
import '../../models/login_model.dart';
import '../../modules/categories/categories_screen.dart';
import '../../modules/favorites/favorites_screen.dart';
import '../../modules/products/products_screen.dart';
import '../../modules/setting/setting_screen.dart';
import '../components/constants.dart';


class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit() : super(ShopInitialState());


  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex=0;

  List<Widget> bottomScreens =[
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
      SettingScreen(),
  ];

  void changeBottom(int index){
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }


  Map<int,bool> favorites = {};
   HomeModel? homeModel;

  void getHomeData(){
    emit(ShopHomeDataLoadingState());

    DioHelper.getData(
        url: HOME,
      token: token,
    )
        .then((value) {
          homeModel=HomeModel.fromJson(value.data);
          // print(homeModel!.status);
          // printFullText(homeModel.toString());

          homeModel!.data!.products.forEach((element) {//for favorites
            favorites.addAll({
              element.id! : element.in_favorites! ,
            });
          });
          print(favorites.toString());



          emit(ShopHomeDataSUCCESSState());
    })
        .catchError((error){
          print(error.toString());
          emit(ShopHomeDataErrorState());
    });

  }


  CategoriesModel? categoriesModel;

  void getCategoriesData(){

    DioHelper.getData(
      url: CATEGORIES,
      token: token,
    )
        .then((value) {
      categoriesModel=CategoriesModel.fromJson(value.data);
      print(categoriesModel!.status);
      emit(ShopCategoriesSUCCESSState());
    })
        .catchError((error){
      print(error.toString());
      emit(ShopCategoriesErrorState());
    });

  }


   ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId){
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesState());


    DioHelper.postData(
        url: FAVORITES,
        data: {
          'product_id' : productId,
        },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);

      if(!changeFavoritesModel!.status!){
        favorites[productId] = !favorites[productId]!;
      }else{
        getFavorites();
      }

      emit(ShopChangeFavoritesSUCCESSState(model: changeFavoritesModel!));
    }).catchError((error){
      favorites[productId] = !favorites[productId]!;
      emit(ShopChangeFavoritesErrorState());
    });
  }



  FavoritesModel? favoriteModel;
  void getFavorites(){

    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    )
        .then((value) {
      favoriteModel=FavoritesModel.fromJson(value.data);
      printFullText(value.data.toString());
      print(favoriteModel!.status);
      emit(ShopGetFavoritesSUCCESSState());
    })
        .catchError((error){
      print(error.toString());
      emit(ShopGetFavoritesErrorState());
    });

  }

   LoginModel? loginModel;
  void getProfileData(){

    emit(ShopLoadingGetProfileDataState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    )
        .then((value) {
      loginModel=LoginModel.fromJson(value.data);
      print(loginModel!.status);
      print('name is : ${loginModel!.data!.name!}');
      emit(ShopGetProfileDataSUCCESSState(loginModel: loginModel));
    })
        .catchError((error){
      print(error.toString());
      emit(ShopGetProfileDataErrorState());
    });

  }




  void updateUserData(
  {
    required String? email,
    required String? phone,
    required String? name,

  }
      ){
    emit(ShopUpdateLoadingState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'email':email,
        'name':name,
        'phone':phone,

      },
    ).then((value)  {
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel!.status);
      emit(ShopUpdateSUCCESSState(loginModel: loginModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopUpdateErrorState());
    });
  }




  CartsModel? cartsModel;
  void addCarts({
  required int id,
}){
    emit(LoadingAddCartsStates());
    DioHelper.postData(
        url: CARTS,
        data: {
          'id ' : id
        }
    ).then((value) {
      print(value.data);
      cartsModel=CartsModel.fromJson(value.data);
      emit(SuccessAddCartsStates(cardModel: cartsModel!));
    }).catchError((error){
      print(error.toString());
      emit(ErrorAddCartsStates(erroe: cartsModel!.message));
    });
  }





}