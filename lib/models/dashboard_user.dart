class DashboardUser {
  final int id;
  final String? username;
  final String? email;
  final String? phone;
  final String? website;

  DashboardUser(
      {required this.id,
      required this.username,
      required this.email,
      required this.phone,
      this.website});

  factory DashboardUser.fromJson(dynamic json) {
    return DashboardUser(
        id: json['id'],
        username: json['username'],
        email: json['email'],
        phone: json['phone'],
        website: json['website']);
  }
}
