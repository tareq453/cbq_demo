import 'package:cbq/models/dashboard_post.dart';
import 'package:cbq/models/dashboard_user.dart';
import 'package:cbq/providers/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostDetail extends StatelessWidget {
  static const String route = "/post_detail_page";

  const PostDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userData =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    int userID = userData['userId'];
    int postID = userData['postId'];
    final dashboardUser = Provider.of<DashboardProvider>(context, listen: false)
        .getDashboardUserById(userID);
    final dashboardPost = Provider.of<DashboardProvider>(context, listen: false)
        .getDashboardPostById(postID, userID);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post Details"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 32, top: 18),
            child: Text(
              "User Post Details",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          _postDetails(dashboardUser, dashboardPost),
        ],
      ),
    );
  }

  Widget _postDetails(
      DashboardUser? dashboardUser, DashboardPost? dashboardPost) {
    return Wrap(children: [
      Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey.shade300)),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _detailItem('User Name', dashboardUser?.username ?? ''),
              _styledDivider(),
              _detailItem('Web Site', dashboardUser?.website ?? ''),
              _styledDivider(),
              _detailItem('Email', dashboardUser?.email ?? ''),
              _styledDivider(),
              _detailItem('Phone', dashboardUser?.phone ?? ''),
              _styledDivider(),
              _detailItem(
                  'Post Body', dashboardPost?.body.substring(0, 25) ?? ''),
            ],
          ),
        ),
      ),
    ]);
  }

  Widget _detailItem(String title, String description) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(title),
            ),
          ),
          SizedBox(
            width: 1,
            height: 45,
            child: Container(
              color: Colors.grey.shade300,
            ),
          ),
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(description),
              ))
        ],
      ),
    );
  }

  Widget _styledDivider() {
    return Divider(
      height: 3,
      thickness: 1,
      color: Colors.grey.shade300,
    );
  }
}
