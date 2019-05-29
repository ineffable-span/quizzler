import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import './quiz_brain.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Quizzler'),
        backgroundColor: Colors.black,
      ),
      body: QuizPage(),
    ));
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  QuizBrain quizBrain = QuizBrain();

  List<Icon> scoreKeeper = [];

  int quizScore = 0;

  void addIcon(bool iconType) {
    scoreKeeper.add(Icon(
      iconType ? Icons.check : Icons.close,
      color: iconType ? Colors.green : Colors.red,
    ));
  }

  void checkAnswer(bool userAnswer) {
    setState(() {
      if (quizBrain.isFinished()) {
        setState(() {
          Alert(
                  context: context,
                  title: "Done Quizzing!",
                  desc: "Your score is $quizScore / 13")
              .show();
          quizBrain.reset();
          scoreKeeper.clear();
        });
      } else {
        (quizBrain.getAnswer() == userAnswer) ? addIcon(true) : addIcon(false);
        if (quizBrain.getAnswer() == userAnswer) quizScore++;
        quizBrain.nextQuestion();
      }
    });
  }

  Expanded makeFlatButton(bool iconType) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FlatButton(
          onPressed: () {
//            checkAnswer(iconType);
            setState(() {
              Alert(
                      context: context,
                      title: "RFLUTTER",
                      desc: "Flutter is awesome.")
                  .show();
            });
          },
          child: Text(
            iconType ? 'True' : 'False',
            style: TextStyle(fontSize: 16.0),
          ),
          color: iconType ? Colors.green : Colors.red,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Center(
            child: Text(
              quizBrain.getQuestion(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FlatButton(
              onPressed: () => checkAnswer(true),
              child: Text(
                'True',
                style: TextStyle(fontSize: 16.0),
              ),
              color: Colors.green,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FlatButton(
              onPressed: () => checkAnswer(false),
              child: Text(
                'False',
                style: TextStyle(fontSize: 16.0),
              ),
              color: Colors.red,
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}
