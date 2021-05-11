import 'dart:ui';

import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  final FormFieldSetter<String> onSaved;
  final FormFieldSetter<String> onChanged;
  final FormFieldValidator<String> validator;
  final bool obscureText;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hint;

  FormInput({
    this.controller,
    this.focusNode,
    this.inputAction,
    this.inputType,
    this.obscureText = false,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        textInputAction: inputAction,
        obscureText: obscureText,
        onSaved: onSaved,
        onChanged: onChanged,
        validator: validator,
        style: Theme.of(context).textTheme.headline3,
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: Theme.of(context).textTheme.headline3,
            isDense: true,
            contentPadding: EdgeInsets.only(
              bottom: 8,
            )),
      ),
    );
  }
}
