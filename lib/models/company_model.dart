import 'package:company_finder_app/models/company_address.dart';

class CompanyModel {
  String? name;
  String? companyStatus;
  String? city;
  String? country;
  String? address1;
  String? address2;
  String? state;
  String? phone;
  String? fax;
  String? email;
  int? orbNumber;
  String? fetchURL;
  CompanyAddress? address;

  CompanyModel(
      {this.name,
      this.companyStatus,
      this.city,
      this.country,
      this.address1,
      this.address2,
      this.state,
      this.email,
      this.fax,
      this.phone,
      this.orbNumber,
      this.fetchURL,
      this.address});
}
