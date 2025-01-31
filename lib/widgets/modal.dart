import 'package:ez_navy_app/routes/routes.dart';
import 'package:ez_navy_app/routes/routes_names.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class CustomModal extends StatelessWidget {
  final String? title;
  final String? content;
  final String? rightButtonText;
  final VoidCallback? rightButtonOnClick;
  final String? leftButtonText;
  final VoidCallback? leftButtonOnClick;

  const CustomModal({
    super.key,
    this.title,
    this.content,
    this.rightButtonText,
    this.rightButtonOnClick,
    this.leftButtonText,
    this.leftButtonOnClick,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title != null && title!.isNotEmpty ? Text(title!) : null,
      content: content != null && content!.isNotEmpty
          ? Text(content!)
          : const Text('Are you sure you want to continue?'),
      actions: <Widget>[
        if (leftButtonText != null && leftButtonText!.isNotEmpty)
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: Text(leftButtonText!),
            onPressed: leftButtonOnClick ?? () => Navigator.of(context).pop(),
          ),
        if (rightButtonText != null && rightButtonText!.isNotEmpty)
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: Text(rightButtonText!),
            onPressed:
                rightButtonOnClick ?? () => Navigator.of(context).pop(),
          ),
      ],
    );
  }
}

