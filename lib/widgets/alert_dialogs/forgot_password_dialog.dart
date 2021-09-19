//TODO: Improve the code man please

import 'package:flutter/material.dart';
import 'package:noobs2pro_app/services/firebase_auth.dart';
import 'package:noobs2pro_app/utils/colors.dart';
import 'package:noobs2pro_app/utils/helpers.dart';
import 'package:noobs2pro_app/utils/text_styles.dart';
import 'package:noobs2pro_app/widgets/text_fields/base_text_field.dart';
import 'package:validators/validators.dart' as validator;

class ForgotPasswordDialog extends StatefulWidget {
  const ForgotPasswordDialog({Key? key}) : super(key: key);

  @override
  _ForgotPasswordDialogState createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  final _forgotPasswordFormKey = GlobalKey<FormState>();
  final forgotPasswordController = TextEditingController();

  String? forgotPassResult;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: isThemeDark(context) ? kBlack : kWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            key: _forgotPasswordFormKey,
            child: BaseTextField(
              hintText: 'Enter your email',
              controller: forgotPasswordController,
              validator: (value) {
                if (validator.isEmail(value!)) {
                  return null;
                }
                return 'Please enter a valid Email';
              },
            ),
          ),
          if (forgotPassResult != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                forgotPassResult == 'success'
                    ? 'Recovery link sent to email'
                    : forgotPassResult!,
                style: categoryTitle.copyWith(
                  color: forgotPassResult == 'success' ? kWhite : kDanger,
                ),
              ),
            ),
        ],
      ),
      actionsPadding: const EdgeInsets.only(right: 8.0),
      actions: [
        TextButton(
          onPressed: () async {
            if (_forgotPasswordFormKey.currentState!.validate()) {
              final String? result = await FirebaseAuthService().forgetPassword(
                forgotPasswordController.text,
              );
              setState(() {
                forgotPassResult = result!.replaceAll('-', ' ');
              });
            }
          },
          child: const Text('SUBMIT'),
        ),
      ],
    );
  }
}
