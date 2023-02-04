import 'package:flutter/material.dart';

class RoundedTextField extends StatefulWidget {
  RoundedTextField(
      {required this.label,
      required this.onChanged,
      required this.validationMessage,
      this.keyboardType = TextInputType.text,
      this.obsureText = false});

  String label;
  Function onChanged;
  bool obsureText;
  TextInputType keyboardType;
  String validationMessage;

  @override
  State<RoundedTextField> createState() => _RoundedTextFieldState();
}

class _RoundedTextFieldState extends State<RoundedTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return widget.validationMessage;
            }
            return null;
          },
          keyboardType: widget.keyboardType,
          onChanged: ((value) => widget.onChanged(value)), //problem
          obscureText: widget.obsureText,
          cursorColor: Colors.greenAccent.shade400,
          style: TextStyle(
            color: Colors.black54,
          ),
          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: TextStyle(
              color: Colors.grey.shade400,
            ),
            focusColor: Colors.greenAccent.shade400,
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.greenAccent.shade400, width: 2.0),
              borderRadius: BorderRadius.circular(50.0),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide: BorderSide(
                color: Colors.grey.shade400,
              ),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
                borderSide: BorderSide(color: Colors.grey.shade400)),
          ),
        ),
        SizedBox(
          height: 30,
        )
      ],
    );
  }

}

