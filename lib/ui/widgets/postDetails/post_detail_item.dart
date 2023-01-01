import 'package:flutter/material.dart';

class PostDetailItem extends StatelessWidget {
  final String _title;
  final String _description;

  const PostDetailItem(this._title, this._description, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(_title),
            ),
          ),
          SizedBox(
            width: 1,
            height: 45,
            child: Container(
              color: Colors.grey.shade300,
            ),
          ),
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(_description),
              ))
        ],
      ),
    );
  }
}
