import 'dart:developer';

import 'package:company_finder_app/models/company_address.dart';
import 'package:company_finder_app/models/company_filter.dart';
import 'package:company_finder_app/models/company_techonology.dart';

import '../models/company_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpService {
  final String appId = 'c66c5dad-395c-4ec6-afdf-7b78eb94166a';
  final String baseURL = 'https://api.orb-intelligence.com/3';
  final String technologiesURL =
      'https://api.orb-intelligence.com/3/dictionaries/technologies/categories';

  HttpService();

  Future<List<CompanyModel>> fetchData(
      {String? name,
      String query = 'search/',
      String? searchQuery,
      CompanyFilter? filter}) async {
    List<CompanyModel> companies = [];
    final response;
    if (filter!.city == null) {
      filter.city = "";
    }
    filter.limitOfResult ??= 5; //ako je limit == null setuje se vrijednost na 5
    filter.numberOfEmployees ??= 'any';

    try {
      if (filter.city != '' ||
          filter.limitOfResult != 5 ||
          filter.numberOfEmployees != 'any') {
        
          response = await http.get(Uri.parse(
              '$baseURL/$query?api_key=$appId&name=$name&city=${filter.city}&limit=${filter.limitOfResult}&employees=${filter.numberOfEmployees}'));
          log('filter');
          log('$filter');
        
      } else {
        response = await http
            .get(Uri.parse('$baseURL/$query?api_key=$appId&name=$name'));
        log('without filter');
      }

      if (response.statusCode == 200) {
        print(json.decode(response.body)['results']);
        final decodedData =
            await json.decode(response.body)['results'] as List<dynamic>;

        decodedData.forEach((element) {
          if (element['name'] != null &&
              element['company_status'] != null &&
              element['city'] != null &&
              element['country'] != null &&
              element['address1'] != null &&
              element['fetch_url'] != null) {
            companies.add(CompanyModel(
                name: element['name'],
                companyStatus: element['company_status'],
                city: element['city'],
                country: element['country'],
                address1: element['address1'],
                fetchURL: element['fetch_url']));
          }
        });

        if (searchQuery != null) {
          companies = companies
              .where((element) => element.name!
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()))
              .toList();
        }

        // filter.city = '';
        // filter.limitOfResult = 5;
        // filter.numberOfEmployees = 'any';
      } else {
        print('status code is ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
    return companies;
  }

  Future<CompanyModel> fetchCompanyDetails(String? fetchUrl) async {
    CompanyModel company = CompanyModel();
    try {
      final response = await http.get(Uri.parse('$fetchUrl'));

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body) as Map<String, dynamic>;
        company.name = decodedData['name'];
        company.orbNumber = decodedData['orb_num'];
        company.companyStatus = decodedData['company_status'];
        final addressData = decodedData['address'] as Map<String, dynamic>;
        log('$addressData');
        CompanyAddress address = CompanyAddress(
            address1: addressData['address1'],
            address2: addressData['address2'],
            city: addressData['city'],
            state: addressData['state'],
            country: addressData['country']);
        company.email = decodedData['email'];
        company.fax = decodedData['fax'];
        company.phone = decodedData['phone'];

        company.address = address;
        log('${company.address}');
      } else {
        print('name is ${company.name}');
        print(company.orbNumber);
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
    return company;
  }

  Future<List<CompanyTechnology>> fetchTechnologies() async {
    final List<CompanyTechnology> technologies = [];

    try {
      final response =
          await http.get(Uri.parse('$technologiesURL/?api_key=$appId'));

      if (response.statusCode == 200) {
        final decodedData = await json.decode(response.body) as List<dynamic>;
        decodedData.forEach((element) {
          technologies.add(CompanyTechnology(
              name: element['name'], technologies: element['technologies']));
        });

        print(technologies);
      }
    } catch (e) {
      print(e);
    }

    return technologies;
  }
}
