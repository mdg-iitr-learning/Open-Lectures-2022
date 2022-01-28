class DataModel {
  final int cases;
  final int todayCases;
  final int recovered;
  final int active;
  final String country;
  final String flag;

  const DataModel({
    required this.cases,
    required this.todayCases,
    required this.recovered,
    required this.active,
    required this.country,
    required this.flag,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      cases: json['cases'],
      todayCases: json['todayCases'],
      recovered: json['recovered'],
      active: json['active'],
      country: json['country'],
      flag:(json['countryInfo'] as Map<String, dynamic>)['flag'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'cases': cases,
      'todayCases': todayCases,
      'recovered': recovered,
      'active': active,
      'country': country,
      'countryInfo': <String, dynamic>{
        'flag': flag,
      }
    };
  }
}
