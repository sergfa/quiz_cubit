import 'package:flutter/material.dart';
import 'package:quiz_cubit/src/constants/constants.dart';
import 'package:quiz_cubit/src/constants/open_trivia/open_trivia_constants.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      leading: Icon(Icons.gamepad),
      title: Text(
        'QUIZ CUBIT',
        style: TextStyle(),
      ),
    );
  }

  Widget _buildBody(BuildContext bodyContext) {
    return Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
      decoration: BoxDecoration(
          /*image: DecorationImage(
          image: AssetImage("assets/background.jpg"),
          fit: BoxFit.cover,
        ),*/
          ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 60.0),
            child: Text(
              'QUIZ CUBIT',
              style: TextStyle(
                  /*color: Colors.grey,*/
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 40.0, right: 40.0),
            child: Column(
              children: [
                _buildMainButton(
                  bodyContext,
                  () => Navigator.of(bodyContext).pushNamed(RouteNames.PLAY,
                      arguments: {
                        "category": -1,
                        "amount": 20,
                        "type": OpenTriviaQuizType.MULTIPLE
                      }),
                  'Random Quiz',
                  Icons.play_arrow_rounded,
                ),
                SizedBox(height: 10.0),
                _buildMainButton(
                  bodyContext,
                  () {
                    Navigator.of(bodyContext).pushNamed(
                      RouteNames.CATEGOREIS,
                    );
                  },
                  'Categories',
                  Icons.category_rounded,
                ),
                SizedBox(height: 10.0),
                _buildMainButton(
                  bodyContext,
                  () {
                    Navigator.of(bodyContext).pushNamed(
                      RouteNames.SCORE,
                    );
                  },
                  'Score',
                  Icons.leaderboard_rounded,
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(bodyContext).pushNamed(RouteNames.SETTINGS);
                  },
                  icon: Icon(Icons.settings),
                  label: Text(
                    'Settings',
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(bodyContext).pushNamed(
                      RouteNames.ABOUT,
                    );
                  },
                  icon: Icon(
                    Icons.help,
                  ),
                  label: Text('About'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMainButton(
      BuildContext context, Function onPressed, String label, IconData icon) {
    return RaisedButton(
        onPressed: onPressed,
        color: Theme.of(context).primaryColor,
        child: Container(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Row(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    icon,
                    /*color: Colors.blueGrey,*/
                  )),
              Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    label,
                    style: TextStyle(
                        /*color: Colors.black,*/
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ))
            ],
          ),
        ),
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(15.0)));
  }
}
