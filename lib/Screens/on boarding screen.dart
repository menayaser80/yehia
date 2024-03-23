import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:yehia/Screens/auth/login.dart';
import 'package:yehia/constants/global%20method.dart';
import 'package:yehia/cubit/cashe%20helper.dart';
class BoardingModel
{
  final String image;
  final String title;
  final String body;
  BoardingModel({
    required this.title,
    required this.image,
    required this.body,
  });
}
class Onboarding extends StatefulWidget {
  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  var boardController=PageController();

  List<BoardingModel>boarding=[
    BoardingModel(
      image:'assets/images/medical-report 1.png',
      title: 'Welcome to Roshta App',
      body: 'Step into Roshta where your health journey begins effortlessly',
    ),
    BoardingModel(
      image:'assets/images/pills 1.png',
      title: 'Picture Perfect Medication',
      body: 'Capture And discover a simple snapshot reveals your medication details',
    ),
    BoardingModel(
      image:'assets/images/mental-health 1.png',
      title: 'Friendly Health Conversations',
      body: 'Meet your virtual health companion chat about medicines for personalized guidance',
    ),
  ];
  bool islast=false;
  void submit()
  {
    CachHelper.saveData(key:'on boarding', value:true,).then((value){
      if(value)
      {
        navigateTo(context,LoginScreen());
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          TextButton(onPressed:submit,
              child: Text(
                'SKIP',
              )),
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index)
                {
                  if(index==boarding.length -1)
                  {
                    setState(()
                    {
                      islast=true;
                    });
                  }else
                  {
                    setState(()
                    {
                      islast=false;
                    });
                  }
                },
                itemBuilder: (context,index)=>buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(controller: boardController,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5.0,
                    activeDotColor:Color(0xFF7441F2),
                  ),
                  count: boarding.length,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if(islast)
                    {
                      submit();
                    }else
                    {
                      boardController.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image: AssetImage('${model.image}'),
        ),
      ),
      SizedBox(
        height: 30.0,
      ),
      Text('${model.title}',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 15.0,
      ),
      Text('${model.body}',
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
    ],
  );
}