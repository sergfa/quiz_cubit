import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz_cubit/src/constants/constants.dart';
import 'package:quiz_cubit/src/constants/open_trivia/open_trivia_constants.dart';
import 'package:quiz_cubit/src/data/models/open_trivia_models.dart';

class CategoriesListView extends StatelessWidget {
  final List<OpenTriviaCategoryItem> items;

  CategoriesListView(this.items);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, i) {
        return Card(
          /*color: Colors.grey,*/
          child: ListTile(
            title: Text(
              items[i].name,
              /*style: TextStyle(color: Colors.black87),*/
            ),
            subtitle: const Text('Best Score: 45'),
            leading: CircleAvatar(
                /*backgroundColor: Colors.blueGrey,*/
                child: Icon(Icons.category_rounded)),
            onTap: () {
              print('pressed ${items[i].value}');
              Navigator.of(context).pushNamed(RouteNames.PLAY, arguments: {
                "category": items[i].value,
                "amount": 20,
                "type": OpenTriviaQuizType.MULTIPLE
              });
            },
            trailing: Icon(Icons.arrow_right),
          ),
        );
      },
      itemCount: items.length,
    );
  }
}
