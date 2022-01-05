import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizmaker/services/database.dart';
import 'package:quizmaker/views/create_quiz.dart';
import 'package:quizmaker/widgets/widgets.dart';
import 'package:quizmaker/views/play_quiz.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late Stream quizStream;
  DatabaseService databaseService = DatabaseService();

  Widget quizList() {
    return Container(
      child: Column(
        children: [
          StreamBuilder(
            stream: quizStream,
            builder: (context, AsyncSnapshot snapshot) {
              return snapshot.data == null
                  ? Container()
                  : ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return QuizTile(
                      imgUrl:
                      snapshot.data.docs[index].data()['quizImgUrl'],
                      title:
                      snapshot.data.docs[index].data()['quizTitle'],
                      desc:
                      snapshot.data.docs[index].data()['quizDescription'],
                      quizId:
                      snapshot.data.docs[index].data()['quizId'],
                    );
                  });
            },
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    databaseService.getQuizzesData().then((val){
      setState(() {
        quizStream = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: quizList(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CreateQuiz()));
        },
      ),
    );
  }
}

class QuizTile extends StatelessWidget {
  late final String imgUrl;
  late final String title;
  late final String desc;
  final String quizId;

  QuizTile({required this.imgUrl, required this.title, required this.desc, required this.quizId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => PlayQuiz(
            quizId
          )
        ));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        height: 150,
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(imgUrl, width: MediaQuery.of(context).size.width - 48, fit: BoxFit.cover,)),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black26,
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text(title, style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                )),
                const SizedBox(height: 6,),
                Text(desc, style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,),
                )
              ],),
            )
          ],
        )
      ),
    );
  }
}
