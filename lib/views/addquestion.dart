import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizmaker/services/database.dart';
import 'package:quizmaker/widgets/widgets.dart';

class AddQuestion extends StatefulWidget {
  final String quizId;
  const AddQuestion(this.quizId);

  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {

  final _formKey = GlobalKey<FormState>();
  late String question, option1, option2, option3, option4;
  bool _isLoading = false;

  DatabaseService databaseService = DatabaseService();

  uploadQuestionData() async {
    if(_formKey.currentState!.validate()){
      setState(() {
        _isLoading = true;
      });

      Map<String, String> questionMap = {
        "question" : question,
        "option1" : option1,
        "option2" : option2,
        "option3" : option3,
        "option4" : option4,
      };

      await databaseService.addQuestionData(questionMap, widget.quizId).then((value){
        setState(() {
          _isLoading = false;
        });
      }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: appBar(context),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      iconTheme: const IconThemeData(color: Colors.black87),
      systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: _isLoading ? Container(
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ) : Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Container(
            child: Column(children: [
              TextFormField(
                validator: (val) =>
                val!.isEmpty ? "Enter Question" : null,
                decoration: const InputDecoration(
                  hintText: "Quiz Question",
                ),
                onChanged: (val) {
                  question = val;
                },
              ),
              const SizedBox(
                height: 6,
              ),
              TextFormField(
                validator: (val) =>
                val!.isEmpty ? "Enter Option 1" : null,
                decoration: const InputDecoration(
                  hintText: "Option 1 (Correct Answer)",
                ),
                onChanged: (val) {
                  option1 = val;
                },
              ),
              const SizedBox(
                height: 6,
              ),
              TextFormField(
                validator: (val) =>
                val!.isEmpty ? "Enter Option 2" : null,
                decoration: const InputDecoration(
                  hintText: "Option 2",
                ),
                onChanged: (val) {
                  option2 = val;
                },
              ),
              const SizedBox(
                height: 6,
              ),
              TextFormField(
                validator: (val) =>
                val!.isEmpty ? "Enter Option 3" : null,
                decoration: const InputDecoration(
                  hintText: "Option 3",
                ),
                onChanged: (val) {
                  option3 = val;
                },
              ),
              const SizedBox(
                height: 6,
              ),
              TextFormField(
                validator: (val) =>
                val!.isEmpty ? "Enter Option 4" : null,
                decoration: const InputDecoration(
                  hintText: "Option 4",
                ),
                onChanged: (val) {
                  option4 = val;
                },
              ),
              const Spacer(),
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: blueButton(context, "Submit", MediaQuery.of(context).size.width/2 - 36)),
                  const SizedBox(width: 24,),
                  GestureDetector(
                      onTap: (){
                        uploadQuestionData();
                      },
                      child: blueButton(context, "Add Question", MediaQuery.of(context).size.width/2 - 36)),
                ],
              ),
              const SizedBox(
                height: 60,
              )
            ],)
          ),
        ),
      )
    );
  }
}
