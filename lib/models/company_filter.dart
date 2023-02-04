
class CompanyFilter {

  CompanyFilter({this.city, this.numberOfEmployees, this.limitOfResult});

  String? city;
  String? numberOfEmployees;
  int? limitOfResult;

  @override
  String toString() {
    
    return '$city $numberOfEmployees $limitOfResult';
  }
}