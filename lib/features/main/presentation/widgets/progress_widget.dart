import 'package:flutter/material.dart';

class ProgressWidget extends StatelessWidget {
  final String? progressText;
  const ProgressWidget(this.progressText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                "$progressText",
                style: Theme.of(context).textTheme.titleMedium,
              )
            ],
          ),
        ),
      ),
    );
  }
}