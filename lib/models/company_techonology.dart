
class CompanyTechnology {
  String? name;
  List<String>? technologies;

  CompanyTechnology({this.name, this.technologies});

  CompanyTechnology.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    technologies = json['technologies'].cast<String>();
  }
}