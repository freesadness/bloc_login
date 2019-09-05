import 'package:dongey/src/ui/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body: LoadingIndicator(),
      );
  }
}
