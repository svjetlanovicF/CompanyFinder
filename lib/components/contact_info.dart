import 'package:flutter/material.dart';
import '../models/company_model.dart';
import './row_data_in_company.dart';
import 'package:open_mail_app/open_mail_app.dart';

class ContactInfo extends StatefulWidget {
  Map<String, String> labels;
  CompanyModel? companyContactData;

  ContactInfo({required this.labels, required this.companyContactData});

  @override
  State<ContactInfo> createState() => _ContactInfoState();
}

class _ContactInfoState extends State<ContactInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      margin: EdgeInsets.fromLTRB(8, 4, 8, 8),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.25,
      // color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Contact Information',
            style: TextStyle(
              color: Colors.greenAccent.shade400,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  '${widget.labels['email']}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                flex: 1,
              ),
              Expanded(
                flex: 2,
                child: InkWell(
                    onTap: () {},
                    child: Text(
                      '${widget.companyContactData!.email}',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    )),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          RowDataInCompany(
            title: '${widget.labels['phone']}',
            data: '${widget.companyContactData!.phone}',
          ),
          SizedBox(
            height: 10,
          ),
          RowDataInCompany(
            title: '${widget.labels['fax']}',
            data: '${widget.companyContactData!.fax}',
          ),
        ],
      ),
    );
  }
}
