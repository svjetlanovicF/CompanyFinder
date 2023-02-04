import 'package:flutter/material.dart';

class RowDataInCompany extends StatefulWidget {
  String title;
  String data;

  RowDataInCompany({required this.title, required this.data});

  @override
  State<RowDataInCompany> createState() => _RowDataInCompanyState();
}

class _RowDataInCompanyState extends State<RowDataInCompany> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            widget.title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          flex: 1,
        ),
        Expanded(
          child: Text(
            widget.data.toUpperCase(),
            textAlign: TextAlign.start,
          ),
          flex: 2,
        ),
      ],
    );
  }
}