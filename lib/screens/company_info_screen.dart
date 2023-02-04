import 'package:company_finder_app/models/company_model.dart';
import 'package:company_finder_app/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:open_mail_app/open_mail_app.dart';
import '../components/contact_info.dart';
import '../components/location_card_info.dart';
import '../components/main_card_info.dart';
import '../components/rating_bar.dart';

final Map<String, String> mainLabels = {
  'name': 'Name',
  'number': 'Number',
  'status': 'Status'
};

final Map<String, String> locationLabels = {
  'address1': 'Address1',
  'address2': 'Address2',
  'state': 'State',
  'city': 'City',
  'country': 'Country',
};

final Map<String, String> contactLabels = {
  'email': 'Email',
  'fax': 'Fax',
  'phone': 'Phone'
};

class CompanyInfoScreen extends StatefulWidget {
  String? fetchURL;

  CompanyInfoScreen({required this.fetchURL});

  @override
  State<CompanyInfoScreen> createState() => _CompanyInfoScreenState();
}

class _CompanyInfoScreenState extends State<CompanyInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent.shade400,
      ),
      backgroundColor: Colors.grey.shade200,
      body: ListView(
        children: [
          FutureBuilder(
            future: HttpService().fetchCompanyDetails(widget.fetchURL),
            builder: (context, snapshot) {
              var data = snapshot.data;
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Column(children: [
                  MainCardInfo(
                    labels: mainLabels,
                    company: data,
                  ),
                  LocationCardInfo(labels: locationLabels, company: data),
                  ContactInfo(labels: contactLabels, companyContactData: data),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                        child: Column(
                      children: [
                        const Text('How much do you like this company?'),
                        Center(child: RatingBar()),
                      ],
                    )),
                  ),
                ]);
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: Icon(
          Icons.favorite_rounded,
          color: Colors.white,
        ),
        backgroundColor: Colors.greenAccent.shade400,
      ),
    );
  }
}
