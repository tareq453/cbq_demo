import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final String? _errorMessage;

  const CustomErrorWidget(this._errorMessage, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(_errorMessage ?? "!"),
    );
  }
}
