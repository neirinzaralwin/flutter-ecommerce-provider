import 'package:ecommerce_app/components/widgets.dart';
import 'package:ecommerce_app/utils/colors.dart';
import 'package:ecommerce_app/utils/dimensions.dart';
import 'package:flutter/material.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;

  double textHeight = Dimensions.screenHeight / 5.63;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? Text(
              firstHalf,
              style: TextStyle(color: Colors.black.withOpacity(0.7)),
            )
          : Column(
              children: [
                GestureDetector(
                  onDoubleTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: SmallText(hiddenText
                      ? (firstHalf + '...')
                      : (firstHalf + secondHalf)),
                ),
                // show more button
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(children: [
                    Text(
                      hiddenText ? 'Show more' : 'Show less',
                      style: TextStyle(color: primaryColor.withOpacity(0.7)),
                    ),
                    Icon(
                      hiddenText ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                      color: primaryColor,
                    )
                  ]),
                ),
                SizedBox(height: 10),
              ],
            ),
    );
  }
}
