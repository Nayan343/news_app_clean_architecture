import 'package:flutter/material.dart';

import 'progress_widget.dart';

class ProgressErrorWidget extends StatelessWidget {
  final Widget child;
  final Widget? progressWidget;
  final bool? isProgressRunning;
  final String? progressText;
  final double progressWidgetOpacity;
  final bool? isError;
  final String? errorText;
  final Function? onPressed;

  const ProgressErrorWidget(
      {super.key,
      required this.child,
      required this.isProgressRunning,
      this.progressText = "Please Wait",
      this.progressWidgetOpacity = 0.6,
      this.progressWidget,
      this.isError,
      this.errorText = "An Error Occurred",
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(isProgressRunning == false),
      child: Stack(
        children: <Widget>[
          child,
          Visibility(
              visible: isProgressRunning ?? false,
              child: Container(
                  color: Colors.grey.withOpacity(progressWidgetOpacity),
                  child: progressWidget ?? ProgressWidget(progressText))),
          Visibility(
            visible: isProgressRunning == false && isError == true,
            child: Container(
              padding: const EdgeInsets.all(10),
              color: Colors.grey.withOpacity(progressWidgetOpacity),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const Text(
                              "Error",
                              style: TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              height: 10,
                            ),Text(
                              "$errorText",
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            OutlinedButton(
                                onPressed: () {
                                  if (onPressed != null) {
                                    onPressed!();
                                  }
                                },
                                child: const Text("Ok")),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
