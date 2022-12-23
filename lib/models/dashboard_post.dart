class DashboardPost {
  final int userId;
  final int postId;
  final String title;
  final String body;

  DashboardPost(
      {required this.userId,
      required this.postId,
      required this.title,
      required this.body});

  factory DashboardPost.fromJson(dynamic json) {
    return DashboardPost(
        userId: json['userId'],
        postId: json['id'],
        title: json['title'],
        body: json['body']);
  }
}
