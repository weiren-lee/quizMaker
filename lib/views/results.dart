import 'package:flutter/material.dart';
import 'package:quizmaker/widgets/widgets.dart';

class Results extends StatefulWidget {
  late final int correct, incorrect, total;
  Results({required this.correct, required this.incorrect, required this.total});

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${widget.correct}/${widget.total}",
                style: const TextStyle(fontSize: 25),),
              const SizedBox(height: 8,),
              Text("You have answered ${widget.correct} answers correctly and ${widget.incorrect} answers incorrectly.",
                style: const TextStyle(fontSize: 15, color: Colors.grey),
                textAlign: TextAlign.center,),
              const SizedBox(height: 14,),
              GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: blueButton(context, "Go to Home"),
              )],
          ),
        ),
      ),
    );
  }
}
