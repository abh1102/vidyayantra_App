class SchoolModel {
  final String id;
  final String code;
  final String name;
  final String? logo;
  final String? address;
  final String? primaryColor;
  final String? secondaryColor;

  SchoolModel({
    required this.id,
    required this.code,
    required this.name,
    this.logo,
    this.address,
    this.primaryColor,
    this.secondaryColor,
  });

  factory SchoolModel.fromJson(Map<String, dynamic> json) {
    return SchoolModel(
      id: json['id'] ?? '',
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      logo: json['logo'],
      address: json['address'],
      primaryColor: json['primary_color'],
      secondaryColor: json['secondary_color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'logo': logo,
      'address': address,
      'primary_color': primaryColor,
      'secondary_color': secondaryColor,
    };
  }
}
