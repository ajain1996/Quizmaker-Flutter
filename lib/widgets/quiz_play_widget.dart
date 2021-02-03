import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OptionTile extends StatefulWidget {
  final String option, description, correctAnswer, optionSelected;
  OptionTile({
    @required this.correctAnswer,
    @required this.description,
    @required this.option,
    @required this.optionSelected,
  });

  @override
  _OptionTileState createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: widget.description == widget.optionSelected
                  ? widget.optionSelected == widget.correctAnswer
                      ? Colors.green.withOpacity(0.7)
                      : Colors.red.withOpacity(0.7)
                  : Colors.white,
              border: Border.all(
                color: widget.description == widget.optionSelected
                    ? widget.optionSelected == widget.correctAnswer
                        ? Colors.green.withOpacity(0.7)
                        : Colors.red.withOpacity(0.7)
                    : Colors.grey,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: Text(
                '${widget.option}',
                style: TextStyle(
                  color: widget.optionSelected == widget.description
                      ? widget.correctAnswer == widget.optionSelected
                          ? Colors.white.withOpacity(0.7)
                          : Colors.white
                      : Colors.grey,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0),
            child: Text("${widget.description}"),
          ),
        ],
      ),
    );
  }
}
