import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizmaker/models/question_model.dart';
import 'package:quizmaker/services/database.dart';
import 'package:quizmaker/views/results.dart';
import 'package:quizmaker/widgets/quiz_play_widget.dart';
import 'package:quizmaker/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PlayQuiz extends StatefulWidget {

  late final String quizId;
  PlayQuiz(this.quizId);

  @override
  _PlayQuizState createState() => _PlayQuizState();
}

int total = 0;
int _correct = 0;
int _incorrect = 0;
int _notAttempted = 0;

class _PlayQuizState extends State<PlayQuiz> {

  DatabaseService databaseService = DatabaseService();
  late QuerySnapshot questionsSnapshot;

  QuestionModel getQuestionModelFromDataSnapshot(DocumentSnapshot questionSnapshot) {
    QuestionModel questionModel = QuestionModel();
    questionModel.question = questionSnapshot["question"];

    List<String> options =
        [
          questionSnapshot["option1"],
          questionSnapshot["option2"],
          questionSnapshot["option3"],
          questionSnapshot["option4"],
        ];
    options.shuffle();
    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctOption = questionSnapshot["option1"];
    questionModel.answered = false;

    return questionModel;
  }

  @override
  void initState() {
    print(widget.quizId);
    databaseService.getQuizData(widget.quizId).then((value){
      questionsSnapshot = value;
      _notAttempted = 0;
      _correct = 0;
      _incorrect = 0;
      total = questionsSnapshot.docs.length;
      print("$total this is total");
      setState(() {

      });
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: Colors.black54
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Container(
        child: Column(
          children: [
            questionsSnapshot == null ?
                Container(
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ):
            ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: questionsSnapshot.docs.length,
              itemBuilder: (context, index){
                return QuizPlayTile(getQuestionModelFromDataSnapshot(questionsSnapshot.docs[index]), index);
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check),
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => Results(correct: _correct, incorrect: _incorrect, total: total,))
          );
        },
      ),
    );
  }
}

class QuizPlayTile extends StatefulWidget {

  late final QuestionModel questionModel;
  final int index;
  QuizPlayTile(this.questionModel, this.index);

  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {

  String optionSelected = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text("Q${widget.index+1} " + widget.questionModel.question, style: const TextStyle(fontSize: 17, color: Colors.black87),),
        const SizedBox(height: 12,),
        GestureDetector(
            onTap: (){
              if(!widget.questionModel.answered){
                if(widget.questionModel.option1 == widget.questionModel.correctOption){
                  optionSelected = widget.questionModel.option1;
                  widget.questionModel.answered = true;
                  _correct += 1;
                  _notAttempted -= 1;
                  setState(() {
                  });
                }else {
                  optionSelected = widget.questionModel.option1;
                  widget.questionModel.answered = true;
                  _incorrect += 1;
                  _notAttempted -= 1;
                  setState(() {
                  });
                }
              }
            },
            child: OptionTile(optionSelected: optionSelected, correctAnswer: widget.questionModel.correctOption, description: widget.questionModel.option1, option: "A")),
        const SizedBox(height: 4,),
        GestureDetector(
            onTap: (){
              if(!widget.questionModel.answered){
                if(widget.questionModel.option2 == widget.questionModel.correctOption){
                  optionSelected = widget.questionModel.option2;
                  widget.questionModel.answered = true;
                  _correct += 1;
                  _notAttempted -= 1;
                  setState(() {
                  });
                }else {
                  optionSelected = widget.questionModel.option2;
                  widget.questionModel.answered = true;
                  _incorrect += 1;
                  _notAttempted -= 1;
                  setState(() {
                  });
                }
              }
            },
            child: OptionTile(optionSelected: optionSelected, correctAnswer: widget.questionModel.correctOption, description: widget.questionModel.option2, option: "B")),
        const SizedBox(height: 4,),
        GestureDetector(
            onTap: (){
              if(!widget.questionModel.answered){
                if(widget.questionModel.option3 == widget.questionModel.correctOption){
                  optionSelected = widget.questionModel.option3;
                  widget.questionModel.answered = true;
                  _correct += 1;
                  _notAttempted -= 1;
                  setState(() {
                  });
                }else {
                  optionSelected = widget.questionModel.option3;
                  widget.questionModel.answered = true;
                  _incorrect += 1;
                  _notAttempted -= 1;
                  setState(() {
                  });
                }
              }
            },
            child: OptionTile(optionSelected: optionSelected, correctAnswer: widget.questionModel.correctOption, description: widget.questionModel.option3, option: "C")),
        const SizedBox(height: 4,),
        GestureDetector(
            onTap: (){
              if(!widget.questionModel.answered){
                if(widget.questionModel.option4 == widget.questionModel.correctOption){
                  optionSelected = widget.questionModel.option4;
                  widget.questionModel.answered = true;
                  _correct += 1;
                  _notAttempted -= 1;
                  setState(() {
                  });
                }else {
                  optionSelected = widget.questionModel.option4;
                  widget.questionModel.answered = true;
                  _incorrect += 1;
                  _notAttempted -= 1;
                  setState(() {
                  });
                }
              }
            },
            child: OptionTile(optionSelected: optionSelected, correctAnswer: widget.questionModel.correctOption, description: widget.questionModel.option4, option: "D")),
          const SizedBox(height: 20,),
        ],),
    );
  }
}

