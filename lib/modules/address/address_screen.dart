// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/address/cubit/cubit.dart';
import 'package:shop/modules/address/cubit/states.dart';
import 'package:shop/shared/components/form_field.dart';

import '../../shared/components/default_button.dart';
import '../../shared/components/toast_package.dart';

class AddressScreen extends StatelessWidget {
  AddressScreen({Key? key}) : super(key: key);
  var nameAddressController = TextEditingController();
  var cityAddressController = TextEditingController();
  var regionAddressController = TextEditingController();
  var detailsAddressController = TextEditingController();
  var latitudeAddressController = TextEditingController();
  var longitudeAddressController = TextEditingController();

  var formKey = GlobalKey<FormState>();


  @override
  Widget build(
    BuildContext context,
  ) {
    return BlocProvider(
      create: (BuildContext context) => AddressCubit()..getAddress(),
      child: BlocConsumer<AddressCubit, AddressStates>(
        listener: (BuildContext context, state) {
          if (state is AddAddressSUCCESSState) {
            if (state.addressModel.status!) {
              print(state.addressModel.message);
              showToast(
                text: state.addressModel.message!,
                state: ToastStates.SUCCESS,
              );
            } else {
              showToast(
                text: state.addressModel.message!,
                state: ToastStates.ERROR,
              );
            }
          }

        },
        builder: (BuildContext context, Object? state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Address'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      defaultFormField(
                          controller: nameAddressController,
                          type: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'Address must not be null';
                            return null;
                          },
                          label: 'name',
                          prefix: Icons.home_outlined,
                          onTap: () {
                            print(nameAddressController);
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          controller: cityAddressController,
                          type: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'your city please';
                            return null;
                          },
                          label: 'city',
                          prefix: Icons.maps_home_work_outlined,
                          onTap: () {
                            print(cityAddressController);
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          controller: regionAddressController,
                          type: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'your region please';
                            return null;
                          },
                          label: 'region',
                          prefix: Icons.maps_home_work_outlined,
                          onTap: () {
                            print(regionAddressController);
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          controller: detailsAddressController,
                          type: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'short code for your location must not be null';
                            return null;
                          },
                          label: 'Code Location',
                          prefix: Icons.maps_home_work_outlined,
                          onTap: () {
                            print(detailsAddressController);
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          controller: latitudeAddressController,
                          type: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'latitude ?? ';
                            return null;
                          },
                          label: 'latitude',
                          prefix: Icons.maps_home_work_outlined,
                          onTap: () {
                            print(latitudeAddressController);
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          controller: longitudeAddressController,
                          type: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'longitude ??';
                            return null;
                          },
                          label: 'longitude',
                          prefix: Icons.maps_home_work_outlined,
                          onTap: () {
                            print(longitudeAddressController);
                          }),
                      SizedBox(
                        height: 20,
                      ),

                      ConditionalBuilder(
                        condition: state is! LoadingAddressState,
                        builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                AddressCubit.get(context).addAddress(
                                  name: nameAddressController.text,
                                  city: cityAddressController.text,
                                  region: regionAddressController.text,
                                  details: detailsAddressController.text,
                                  latitude: latitudeAddressController.text,
                                  longitude: longitudeAddressController.text,
                                );
                              }
                            },
                            text: 'Add Address',
                            background: Colors.blueGrey,
                            isUpperCase: false),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
