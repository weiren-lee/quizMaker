import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizmaker/services/database.dart';
import 'package:quizmaker/views/addquestion.dart';
import 'package:quizmaker/widgets/widgets.dart';
import 'package:random_string/random_string.dart';

class CreateQuiz extends StatefulWidget {
  const CreateQuiz({Key? key}) : super(key: key);

  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formKey = GlobalKey<FormState>();
  late String quizImageUrl, quizTitle, quizDescription, quizId;
  DatabaseService databaseService = DatabaseService();

  bool _isLoading = false;

  createQuizOnline() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      quizId = randomAlphaNumeric(16);

      Map<String, String> quizMap = {
        "quizId": quizId,
        "quizImgUrl": quizImageUrl,
        "quizTitle": quizTitle,
        "quizDescription": quizDescription,
      };

      await databaseService.addQuizData(quizMap, quizId).then((value) {
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => AddQuestion(
                quizId
              )));
        });
      });
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
        body: _isLoading
            ? Container(
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (val) =>
                            val!.isEmpty ? "Enter Image Url" : null,
                        decoration: const InputDecoration(
                          hintText: "Quiz Image Url",
                        ),
                        onChanged: (val) {
                          quizImageUrl = val;
                        },
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      TextFormField(
                        validator: (val) =>
                            val!.isEmpty ? "Enter Quiz Url" : null,
                        decoration: const InputDecoration(
                          hintText: "Quiz Title",
                        ),
                        onChanged: (val) {
                          quizTitle = val;
                        },
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      TextFormField(
                        validator: (val) =>
                            val!.isEmpty ? "Enter Quiz Description" : null,
                        decoration: const InputDecoration(
                          hintText: "Quiz Description",
                        ),
                        onChanged: (val) {
                          quizDescription = val;
                        },
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Spacer(),
                      GestureDetector(
                          onTap: () {
                            createQuizOnline();
                          },
                          child: blueButton(context, "Sign Up")),
                      const SizedBox(
                        height: 60,
                      ),
                    ],
                  ),
                ),
              ));
  }
}
