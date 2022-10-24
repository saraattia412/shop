import 'package:shop/models/address_model.dart';

import '../../../models/get_address_model.dart';

abstract class AddressStates {}

class InitialAddressState extends AddressStates{}

class LoadingGetAddressState extends AddressStates{}

class GetAddressSUCCESSState extends AddressStates{
  late final GetAddressModel getAddressModel;
  GetAddressSUCCESSState({required this.getAddressModel});
}

class GetAddressErrorState extends AddressStates{
  late final error;
  GetAddressErrorState({required this.error});
}

class LoadingAddressState extends AddressStates{}

class AddAddressSUCCESSState extends AddressStates{
  late final AddressModel addressModel ;
  AddAddressSUCCESSState({required this.addressModel});
}

class AddAddressErrorState extends AddressStates{
  late final error;
  AddAddressErrorState({required this.error});
}

