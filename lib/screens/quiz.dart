import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List questions;
  String currentTitle;
  String currentCorrectAnswer;
  List<dynamic> currentAnswers;
  int corrects;
  int currentQuestion;
  int selectedAnswer;

  @override
  void initState() {
    this.corrects = 0;
    this.currentQuestion = 0;
    this.questions = null;
    this.selectedAnswer = null;
    this.getQuestions();
    super.initState();
  }

  void getQuestions() async {
    final response =
        await http.get('https://opentdb.com/api.php?amount=10&category=9');
    Map data = json.decode(response.body);
    setState(() {
      this.questions = data['results'];
      this.currentTitle = data['results'][0]['question'];
      this.currentCorrectAnswer = data['results'][0]['correct_answer'];
      this.currentAnswers = [data['results'][0]['correct_answer']] +
          data['results'][0]['incorrect_answers'];
    });
  }

  void verifyAndNext() {
    String textSelectAnswer = this.currentAnswers[this.selectedAnswer];
    print(textSelectAnswer);
    print(this.currentCorrectAnswer);
    if(textSelectAnswer == this.currentCorrectAnswer) {
      setState(() {
        this.corrects++;
      });
    }
    this.nextQuestion();
  }

  void nextQuestion() {
    int actualQuestion = this.currentQuestion;
    if(actualQuestion + 1 < this.questions.length) {
      setState(() {
        this.currentQuestion++;
        this.currentTitle = this.questions[actualQuestion+1]['question'];
        this.currentCorrectAnswer = this.questions[actualQuestion+1]['correct_answer'];
        this.currentAnswers = [this.questions[actualQuestion+1]['correct_answer']] + this.questions[actualQuestion+1]['incorrect_answers'];
        this.selectedAnswer = null;
      });
    }
    print(this.corrects);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: SafeArea(
          child: (this.questions != null)
              ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'Question ${this.currentQuestion + 1}',
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '/${this.questions.length}',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[300],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(25.0),
                        margin: const EdgeInsets.symmetric(vertical: 30.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          this.currentTitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: this.currentAnswers.length + 1,
                          itemBuilder: (context, index) {
                            if (index == this.currentAnswers.length) {
                              return GestureDetector(
                                onTap: this.verifyAndNext,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 15.0,
                                    horizontal: 30.0,
                                  ),
                                  padding: const EdgeInsets.all(15.0),
                                  decoration: BoxDecoration(
                                    color: theme.primaryColor,
                                    borderRadius: BorderRadius.circular(180.0),
                                  ),
                                  child: Text(
                                    'Next',
                                    textAlign: TextAlign.center,
                                    maxLines: 5,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              );
                            }
                            String answer = this.currentAnswers[index];
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  this.selectedAnswer = index;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 15.0),
                                padding: const EdgeInsets.all(15.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: (this.selectedAnswer != index)
                                        ? Colors.white
                                        : theme.primaryColor,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(180.0),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      answer,
                                      style: TextStyle(
                                        color: (this.selectedAnswer != index)
                                            ? Colors.white
                                            : theme.primaryColor,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    Icon(
                                      (this.selectedAnswer != index)
                                          ? Icons.panorama_fish_eye
                                          : Icons.check_circle_outline,
                                      color: (this.selectedAnswer != index)
                                          ? Colors.white
                                          : theme.primaryColor,
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }
}
