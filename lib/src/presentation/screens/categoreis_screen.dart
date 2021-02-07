import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_cubit/src/data/models/open_trivia_models.dart';
import 'package:quiz_cubit/src/logic/cubit/score/score_cubit.dart';
import 'package:quiz_cubit/src/presentation/widgets/categories_list_view.dart';

class CategoriesScreen extends StatelessWidget {
  final List<OpenTriviaCategoryItem> items;

  CategoriesScreen(this.items);

  @override
  Widget build(BuildContext context) {
          
    return Scaffold(
      appBar: _buildAppBar(),
      body:  Container(
        margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
        decoration: BoxDecoration(
          /*image: DecorationImage(
            image: AssetImage("assets/background.jpg"),
            fit: BoxFit.cover,
          ),*/
        ),
        child: CategoriesListView(items),
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text(
        'Categories',
        style: TextStyle(),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [CategoriesListView(items)]),
    );
  }
}
