import 'package:flutter/material.dart';

class GameDailogBuilder {
  static Widget createOkDailaog(BuildContext context,
      {@required String title,
      @required String message,
      @required String buttonLabel,
      @required Function onPressed,
      @required Color avatarColor,
      @required IconData avatarIcon}) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentOkBox(onPressed, context, title, message, buttonLabel,
          avatarColor, avatarIcon),
    );
  }

  static Widget createOkCancekDailaog(
    BuildContext context, {
    @required String title,
    @required String message,
    @required String okLabel,
    @required String cancelLabel,
    @required Function onOkPressed,
    @required Function onCancelPressed,
  }) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentOkCancelBox(
        onOkPressed,
        onCancelPressed,
        context,
        title,
        message,
        okLabel,
        cancelLabel,
      ),
    );
  }

  static Widget contentOkBox(Function onPressed, context, String title,
      String message, String okLabel, Color avatarColor, IconData avatarIcon) {
    return Stack(
      children: <Widget>[
        getBottom(context, title, message, [
          createButton(
            context,
            onPressed,
            okLabel,
          ),
        ]), // bottom part
        top(context, avatarColor, avatarIcon),
      ],
    );
  }

  static Widget contentOkCancelBox(
    Function onOkPressed,
    Function onCanelPressed,
    context,
    String title,
    String message,
    String okLabel,
    String cancelLAbel,
  ) {
    return Stack(
      children: <Widget>[
        getBottom(context, title, message, [
          createButton(context, onOkPressed, okLabel),
          createButton(context, onCanelPressed, cancelLAbel),
        ]), // bottom part
        top(context, Colors.grey, Icons.done),
      ],
    );
  }

  static Widget getBottom(
    BuildContext context,
    String title,
    String message,
    List<Widget> actions,
  ) {
    return Container(
      padding: EdgeInsets.only(
          left: 20.0, top: 45.0 + 20.0, right: 20.0, bottom: 20.0),
      margin: EdgeInsets.only(top: 45.0),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            message,
            style: TextStyle(fontSize: 14, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 22),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: actions,
          )
        ],
      ),
    );
  }

  static Widget createButton(
      BuildContext context, Function onPressed, String label) {
    return Align(
      alignment: Alignment.bottomRight,
      child: FlatButton(
          onPressed: onPressed,
          child: Text(
            label,
            style:
                TextStyle(fontSize: 12, color: Theme.of(context).primaryColor),
          )),
    );
  }

  static Widget top(
      BuildContext context, Color avatarColor, IconData avatarIcon) {
    return Positioned(
      left: 20.0,
      right: 20.0,
      child: CircleAvatar(
        backgroundColor: avatarColor,
        radius: 45.0,
        child: ClipRRect(
          child: Icon(avatarIcon),
        ),
      ),
    );
  }
}
