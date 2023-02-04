import 'package:flutter/material.dart';
import '../models/company_model.dart';
import './row_data_in_company.dart';


class MainCardInfo extends StatefulWidget {
  Map<String, String> labels;
  CompanyModel? company;

  MainCardInfo({required this.labels, required this.company});

  @override
  State<MainCardInfo> createState() => _MainCardInfoState();
}

class _MainCardInfoState extends State<MainCardInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      margin: EdgeInsets.fromLTRB(8, 4, 8, 8),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.2,
      // color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Main Information Company',
            style: TextStyle(
              color: Colors.greenAccent.shade400,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          RowDataInCompany(
            title: '${widget.labels['name']}',
            data: '${widget.company!.name}',
          ),
          SizedBox(
            height: 10,
          ),
          RowDataInCompany(
            title: '${widget.labels['number']}',
            data: '${widget.company!.orbNumber}',
          ),
          SizedBox(
            height: 10,
          ),
          RowDataInCompany(
            title: '${widget.labels['status']}',
            data: '${widget.company!.companyStatus}',
          ),
        ],
      ),
    );
  }
}