import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/address/cubit/states.dart';

import '../../../models/address_model.dart';
import '../../../models/get_address_model.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';

class AddressCubit extends Cubit<AddressStates>{
  AddressCubit() : super(InitialAddressState());


  static AddressCubit get(context) => BlocProvider.of(context);


  GetAddressModel? getAddressModel;
  void getAddress(){
    emit(LoadingGetAddressState());
    DioHelper.getData(
      url: ADDRESS,
      token: token,
    ).then((value) {
      print(value.data);
      getAddressModel=GetAddressModel.fromJson(value.data);
      emit(GetAddressSUCCESSState(getAddressModel: getAddressModel!));
    }).catchError((error){
      print(error.toString());
      emit(GetAddressErrorState(error:getAddressModel!.message));
    });
  }



  AddressModel? addressModel;
  void addAddress(
      {
        required String? name,
        required String? city,
        required String? region,
        required String? details,
        required String? latitude,
        required String? longitude,

      }
      ){
    emit(LoadingAddressState());
    DioHelper.postData(
        url: ADDRESS,
        token: token,
        data: {
          'name' : name,
          'city' : city,
          'region' : region,
          'details' : details,
          'latitude' : latitude,
          'longitude' : longitude,
        }
    ).then((value) {
      print(value.data);
      addressModel=AddressModel.fromJson(value.data);
      emit(AddAddressSUCCESSState(addressModel: addressModel!));
    }).catchError((error){
      print(error.toString());
      emit(AddAddressErrorState(error: addressModel!.message));
    });
  }



}













