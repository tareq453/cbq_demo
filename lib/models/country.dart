class Country {
  final String name;
  final String code;
  final String image;

  Country(this.name, this.code, this.image);

  Map<String, dynamic> toJson() {
    return {"name": name, "code": code, "image": image};
  }

  factory Country.fromJson(dynamic json) {
    return Country(json['name'], json['code'], json['image']);
  }
}
