import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';

class QuizOption extends StatelessWidget {
  final int index;
  final int selectedAnswer;
  final String answer;

  const QuizOption({
    Key key,
    @required this.index,
    @required this.selectedAnswer,
    @required this.answer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size screen = MediaQuery.of(context).size;

    return Container(
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: screen.width * 0.75,
            child: Text(
              HtmlUnescape().convert(answer),
              maxLines: 5,
              style: TextStyle(
                color: (this.selectedAnswer != index)
                    ? Colors.white
                    : theme.primaryColor,
                fontSize: 16.0,
              ),
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
    );
  }
}
