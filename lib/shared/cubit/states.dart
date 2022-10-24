import 'package:shop/models/cartsmodel.dart';
import 'package:shop/models/login_model.dart';

import '../../models/change_favorites_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}

class ShopHomeDataLoadingState extends ShopStates{}

class ShopHomeDataSUCCESSState extends ShopStates{}

class ShopHomeDataErrorState extends ShopStates{}


class ShopCategoriesSUCCESSState extends ShopStates{}

class ShopCategoriesErrorState extends ShopStates{}

class ShopChangeFavoritesState extends ShopStates{}

class ShopChangeFavoritesSUCCESSState extends ShopStates{
  late final ChangeFavoritesModel model;
  ShopChangeFavoritesSUCCESSState({
    required this.model,
});
}

class ShopChangeFavoritesErrorState extends ShopStates{}

class ShopLoadingGetFavoritesState extends ShopStates{}

class ShopGetFavoritesSUCCESSState extends ShopStates{}

class ShopGetFavoritesErrorState extends ShopStates{}

class ShopLoadingGetProfileDataState extends ShopStates{}

class ShopGetProfileDataSUCCESSState extends ShopStates{
  LoginModel? loginModel;
  ShopGetProfileDataSUCCESSState({
    required this.loginModel
});
}

class ShopGetProfileDataErrorState extends ShopStates{}

class ShopUpdateLoadingState extends ShopStates{}

class ShopUpdateSUCCESSState extends ShopStates{
  LoginModel? loginModel;
  ShopUpdateSUCCESSState({
    required this.loginModel
  });
}

class ShopUpdateErrorState extends ShopStates{}




class LoadingAddCartsStates extends ShopStates{}


class SuccessAddCartsStates extends ShopStates{
  late final CartsModel cardModel;
  SuccessAddCartsStates({required this.cardModel});
}


class ErrorAddCartsStates extends ShopStates{
  late final erroe;
  ErrorAddCartsStates({required this.erroe});
}



