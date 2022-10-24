// ignore_for_file: avoid_print, unnecessary_null_comparison, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shop/shared/bloc_observer.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/cubit/cubit.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';
import 'package:shop/shared/styles/theme.dart';



import 'layout/shop_layout.dart';
import 'modules/login/login_screen.dart';
import 'modules/on_boarding/onboarding_screen.dart';

void main()async
{

  //بيتاكد ان كل حاجه ف الميثود هنا خلصت وبعدين يفتح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();//import use with async
  Bloc.observer = MyBlocObserver();
  await DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  late Widget  widget;

  bool?  onBoarding =CacheHelper.getData(key: 'onBoarding');
  token =CacheHelper.getData(key: 'token');
  print('token is $token');



  if(onBoarding != null){
    if(token != null) {
      widget= ShopLayout();
    } else{
      widget = LogInScreen();
    }
  } else{
    widget = const OnBoardingScreen();
  }

  runApp(MyApp(
    startWidget: widget,
    isDark: isDark,

  ));
}

class MyApp extends StatelessWidget {

  final bool? isDark;
  final Widget startWidget;
  const MyApp({Key? key,required this.startWidget, required this.isDark}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return  MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ShopCubit()..getHomeData()
            ..getCategoriesData()..getFavorites()..getProfileData(),
        ),

      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme:lightTheme ,
        themeMode:ThemeMode.light,
        home: startWidget,

      ),
    );
  }
}

