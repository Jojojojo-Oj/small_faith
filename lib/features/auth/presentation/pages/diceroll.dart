import 'dart:math';

import 'package:flutter/material.dart';
import 'package:small_faith/features/auth/presentation/widgets/customButton.dart';

class Diceroll extends StatefulWidget {
  const Diceroll({super.key});

  @override
  State<Diceroll> createState() => _DicerollState();
}

class _DicerollState extends State<Diceroll> {
  var activeImage = "assets/images/dice-1.png";

  void RollDice(){
    setState(() {
      int ran = 1 + Random().nextInt(6);
      activeImage = "assets/images/dice-$ran.png";
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(activeImage, width: 200,height: 200,),

            SizedBox(height: 20,),

            CustomButton(buttonName: "RollDice", backgroundColor: Colors.white, textColor: Colors.black, methodPress: RollDice,)
          ],
        ),
      ),
    );

  }
}