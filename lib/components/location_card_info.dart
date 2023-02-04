import 'package:flutter/material.dart';
import '../models/company_model.dart';
import 'package:maps_launcher/maps_launcher.dart';
import './row_data_in_company.dart';


class LocationCardInfo extends StatefulWidget {
  Map<String, String> labels;
  CompanyModel? company;

  LocationCardInfo({required this.labels, required this.company});

  @override
  State<LocationCardInfo> createState() => _LocationCardInfoState();
}

class _LocationCardInfoState extends State<LocationCardInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      margin: EdgeInsets.fromLTRB(8, 4, 8, 8),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.4,
      // color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Register Office Address',
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
            title: '${widget.labels['address1']}',
            data: '${widget.company!.address!.address1}',
          ),
          SizedBox(
            height: 10,
          ),
          RowDataInCompany(
            title: '${widget.labels['address2']}',
            data: '${widget.company!.address!.address2}',
          ),
          SizedBox(
            height: 10,
          ),
          RowDataInCompany(
            title: '${widget.labels['country']}',
            data: '${widget.company!.address!.country}',
          ),
          SizedBox(
            height: 10,
          ),
          RowDataInCompany(
            title: '${widget.labels['city']}',
            data: '${widget.company!.address!.city}',
          ),
          SizedBox(
            height: 10,
          ),
          RowDataInCompany(
            title: '${widget.labels['state']}',
            data: '${widget.company!.address!.state}',
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () => MapsLauncher.launchQuery(
                '${widget.company!.address!.address1}, ${widget.company!.address!.city}, ${widget.company!.address!.state}, ${widget.company!.address!.country}'),
            child: Text('Show Location on Map'),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Colors.greenAccent.shade400),
            ),
          ),
        ],
      ),
    );
  }
}