// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/components/navigate_and_finish.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/color.dart';
import '../login/login_screen.dart';


class BoardingModel{
  late final String image;
  late final String title;
  late final String body;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
});


}

class OnBoardingScreen extends StatefulWidget {
   const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
   var boardController = PageController();

  List<BoardingModel> boarding=[
    BoardingModel(
        image: 'assets/images/1.jpg',
        title: 'Shopping',
        body: 'more and more third world science and technology educated people are heading '
            'for more prosperous countries seeking higher wages '
            'and better working conditions',
    ),
    BoardingModel(
      image: 'assets/images/2.jpg',
      title: 'Commerce',
      body: 'more and more third world science and technology educated people are heading '
          'for more prosperous countries seeking higher wages '
          'and better working conditions',
    ),
    BoardingModel(
      image: 'assets/images/3.jpg',
      title: 'Banking',
      body: 'more and more third world science and technology educated people are heading '
          'for more prosperous countries seeking higher wages '
          'and better working conditions',
    ),

  ];

  bool isLast = false;

  void submit(){
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if(value){
        navigateAndFinish(context, LogInScreen());
      }
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        actions: [
          TextButton(
              onPressed:submit,
              child: const Text(
                'SKIP',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,

                ),
              ),
          ),
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index){
                  if(index == boarding.length -1){
                    print('last');
                    setState(() {
                      isLast=true;
                    });
                  }
                  else{
                    print('not last');
                    setState(() {
                      isLast=false;
                    });
                  }
                },

                physics: const BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: (context , index)=> buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(height: 40,),
            Row(
              children:  [
                SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                  effect:   ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5,
                    activeDotColor: defaultColor,
                  ),

                ),
                const Spacer(),
                FloatingActionButton(
                  backgroundColor: defaultColor,
                  onPressed: (){
                    if (isLast == true){
                      submit();
                    }
                    else{
                      boardController.nextPage(
                        duration: const Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }

                  },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                  ),

                ),
              ],
            ),
          ],
        ),
      ) ,
    );
  }

  Widget buildBoardingItem(
      BoardingModel model,
      ) => Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children:   [
        Expanded(
          child: Image(image: AssetImage(
            model.image),
          ),
        ),
        const SizedBox(height: 15,),
        Center(
          child: Text(
            model.title,
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
        ),
        const SizedBox(height: 10,),
        Center(
          child: Text(
            model.body,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 10,),


      ]
  );
}
