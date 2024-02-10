import 'package:flutter/material.dart';
import 'package:technupur_test/presentation/dashboard.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {



  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((value) {
      if(mounted){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Dashboard()));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.white,
        child: Column(
          children: [
            Image.asset('assets/images/Background.png' , scale: 2,),
            const SizedBox(height: 20,),
            Image.asset('assets/images/Logo.png' , scale: 4,),
            const SizedBox(height: 20,),
            Spacer(),
            Image.asset('assets/images/power.png' , scale: 4,),
            const SizedBox(height: 40,),

          ],
        )

    );
  }
}
