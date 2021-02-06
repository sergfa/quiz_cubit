import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_cubit/src/constants/open_trivia/open_trivia_constants.dart';
import 'package:quiz_cubit/src/logic/cubit/opentriviaquiz_cubit.dart';
import 'package:quiz_cubit/src/presentation/widgets/dialog.dart';

class PlayScreen extends StatefulWidget {
  final int category;
  final int amount;
  final String type;

  PlayScreen({@required this.category, this.amount, this.type}) {
    print('$category $amount $type');
  }

  @override
  State<StatefulWidget> createState() => PlayScreenState();
}

class PlayScreenState extends State<PlayScreen> {
  @override
  void initState() {
    super.initState();
    setState(() {
      BlocProvider.of<OpenTriviaQuizCubit>(context).startQuiz();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text(
        'Quiz',
        style: TextStyle(),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocConsumer<OpenTriviaQuizCubit, OpenTriviaQuizState>(
        listener: (context, state) {
      if (state is OpenTriviaQuizLoading) {
        buildShowLoadingDialog(context);
      } else if (state is OpenTriviaQuizLoadFailed) {
        Navigator.of(context).pop(true);
        buildShowErrorDialog(context, state.errorMsg);
      } else if (state is OpenTriviaQuizGameInProgress &&
          state.mode == OpenTriviaGameInProgressMode.LOADED) {
        Navigator.of(context).pop(true);
        BlocProvider.of<OpenTriviaQuizCubit>(context).gameStarted();
      } else if (state is OpenTriviaQuizGameInProgress &&
          state.mode == OpenTriviaGameInProgressMode.CORRECT_ANSWER) {
        buildShowCorrectAnswerDialog(context);
      } else if (state is OpenTriviaQuizGameInProgress &&
          state.mode == OpenTriviaGameInProgressMode.WRONG_ANSWER) {
        buildShowWrongAnswerDialog(context);
      } else if (state is OpenTriviaQuizGameInProgress &&
          state.mode == OpenTriviaGameInProgressMode.END_GAME) {
        buildShowEndGameDialog(context);
      }
    }, builder: (context, state) {
      return Container(
        decoration: BoxDecoration(
            /*image: DecorationImage(
            image: AssetImage("assets/background.jpg"),
            fit: BoxFit.cover,
          ),*/
            ),
        margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
        child: createScreenContent(state, context),
      );
    });
  }

  Widget createScreenContent(OpenTriviaQuizState state, BuildContext context) {
    if (state is OpenTriviaQuizStartGame || state is OpenTriviaQuizLoadFailed) {
      return createStartGameWidget(context);
    } else if (state is OpenTriviaQuizGameInProgress) {
      return createGameStartedWidget(context);
    } else {
      return Container(width: 0, height: 0);
    }
  }

  Widget createStartGameWidget(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [createStartButton(context)],
            ),
          ),
        ]);
  }

  Widget createGameStartedWidget(BuildContext context) {
    var state = BlocProvider.of<OpenTriviaQuizCubit>(context).state
        as OpenTriviaQuizGameInProgress;

    return Container(
      margin: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Center(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('${state.items[state.currentQuestion].category}',
                      style: TextStyle(/*color: Colors.grey,*/ fontSize: 15.0)),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Text('${state.currentQuestion + 1}/${state.items.length}',
                          style: TextStyle(
                              /*color: Colors.grey,*/ fontSize: 30.0)),
                      Text('questions',
                          style:
                              TextStyle(/*color: Colors.grey,*/ fontSize: 20.0))
                    ],
                  ),
                ),
              ),
              Spacer(),
              Container(
                child: Center(
                  child: Card(
                      child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          '${state.score}',
                          style:
                              TextStyle(/*color: Colors.grey,*/ fontSize: 30.0),
                        ),
                        Text(
                          'points',
                          style:
                              TextStyle(/*color: Colors.grey,*/ fontSize: 20.0),
                        )
                      ],
                    ),
                  )),
                ),
              )
            ],
          ),
          SizedBox(height: 60.0),
          Container(
            /*color: Colors.grey,*/
            height: 180.0,
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    '${state.items[state.currentQuestion].question}',
                    style: TextStyle(
                      /*color: Colors.black,*/
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Spacer(),
          Container(
            child: Column(
              children: [
                _buildAnswerButton(context,
                    state.items[state.currentQuestion].allAnswers[0], 0),
                SizedBox(height: 15.0),
                _buildAnswerButton(context,
                    state.items[state.currentQuestion].allAnswers[1], 1),
                SizedBox(height: 15.0),
                _buildAnswerButton(context,
                    state.items[state.currentQuestion].allAnswers[2], 2),
                SizedBox(height: 15.0),
                _buildAnswerButton(context,
                    state.items[state.currentQuestion].allAnswers[3], 3),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildShowLoadingDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  buildShowErrorDialog(BuildContext context, String errMessage) {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(errMessage),
            actions: [
              FlatButton(
                onPressed: () => Navigator.pop(context, true), // passing true
                child: Text('Close'),
              ),
            ],
          );
        });
  }

  _buildNextQuestionDialog(String title, message, Color avatarColor, IconData avatarIcon) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return GameDailogBuilder.createOkDailaog(
          context,
          avatarColor: avatarColor,
          avatarIcon: avatarIcon ,
          title: title,
          message: message,
          buttonLabel: 'Next',
          onPressed: () {
            Navigator.pop(context, true);
            var state = BlocProvider.of<OpenTriviaQuizCubit>(context).state
                as OpenTriviaQuizGameInProgress;
            if (state.currentQuestion + 1 >= state.items.length) {
              BlocProvider.of<OpenTriviaQuizCubit>(context).endGame();
            } else {
              BlocProvider.of<OpenTriviaQuizCubit>(context).nextQuestion();
            }
          },
        );
      },
    );
  }

  Future<dynamic> buildShowWrongAnswerDialog(BuildContext context) {
    return _buildNextQuestionDialog(
      'Wrong answer',
      'You can do better!',
      Colors.red,
      Icons.error_outline_rounded
    );
  }

  Future<dynamic> buildShowCorrectAnswerDialog(BuildContext context) {
    return _buildNextQuestionDialog(
      'Correct answer',
      'You are getting better!',
      Colors.green,
      Icons.done_all_rounded
    );
  }

  buildShowEndGameDialog(BuildContext context) {
    var state = BlocProvider.of<OpenTriviaQuizCubit>(context).state
        as OpenTriviaQuizGameInProgress;
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return GameDailogBuilder.createOkCancekDailaog(
            context,
            title: 'Quiz is completed',
            message: 'score: ${state.score}',
            okLabel: 'New quiz',
            cancelLabel: 'Back',
            onOkPressed: () {
              Navigator.pop(context, true);
              BlocProvider.of<OpenTriviaQuizCubit>(context).fetchQuiz(
                  amount: this.widget.amount,
                  type: this.widget.type,
                  category: this.widget.category);
            },
            onCancelPressed: () {
              Navigator.pop(context, true);
              Navigator.pop(context);
            },
          );
        });
  }

  Widget createStartButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        primary: Theme.of(context).primaryColor,
      ),
      child: Container(
        width: 200,
        height: 200,
        alignment: Alignment.center,
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: Text(
          'START QUIZ',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontStyle: FontStyle.italic),
        ),
      ),
      onPressed: () {
        BlocProvider.of<OpenTriviaQuizCubit>(context).fetchQuiz(
            amount: this.widget.amount,
            type: this.widget.type,
            category: this.widget.category);
      },
    );
  }

  Widget _buildAnswerButton(
      BuildContext context, String label, int questionId) {
    var state = BlocProvider.of<OpenTriviaQuizCubit>(context).state
        as OpenTriviaQuizGameInProgress;
    Color answerColor = Theme.of(context).primaryColor; /*Colors.grey;*/
    if (state.mode == 'correctAnswer' && state.answerId == questionId) {
      answerColor = Colors.green;
    } else if (state.mode == 'wrongAnswer' && state.answerId == questionId) {
      answerColor = Colors.red;
    }
    return RaisedButton(
        onPressed: () {
          var state = BlocProvider.of<OpenTriviaQuizCubit>(context).state
              as OpenTriviaQuizGameInProgress;
          if (state.items[state.currentQuestion].correctAnswerIndex ==
              questionId) {
            BlocProvider.of<OpenTriviaQuizCubit>(context)
                .correctAnswer(questionId);
          } else {
            BlocProvider.of<OpenTriviaQuizCubit>(context)
                .wrongAnswer(questionId);
          }
        },
        color: answerColor,
        child: Container(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Row(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 30.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    /*color: Colors.black54,*/
                  ),
                  child: Center(
                    child: Text(
                      '${questionId + 1}',
                      style: TextStyle(
                          /*color: Colors.white54,*/ fontWeight:
                              FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10.0),
                child: Text(
                  label,
                  maxLines: 3,
                  style: TextStyle(
                      /*color: Colors.black,*/
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
              ),
            ],
          ),
        ),
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(20.0)));
  }
}
