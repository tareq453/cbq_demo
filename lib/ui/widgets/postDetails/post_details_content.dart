import 'package:cbq/models/dashboard_post.dart';
import 'package:cbq/models/dashboard_user.dart';
import 'package:cbq/models/post_details.dart';
import 'package:cbq/ui/widgets/custom_divider.dart';
import 'package:cbq/ui/widgets/postDetails/post_detail_item.dart';
import 'package:flutter/material.dart';

class PostDetailsContext extends StatelessWidget {
  final PostDetails? _postDetails;

  const PostDetailsContext(this._postDetails, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 32, top: 18),
          child: Text(
            "User Post Details",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        _postDetailsWidget(
            _postDetails?.dashboardUser, _postDetails?.dashboardPost),
      ],
    );
  }

  Widget _postDetailsWidget(
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
              PostDetailItem('User Name', dashboardUser?.username ?? ''),
              const CustomDivider(),
              PostDetailItem('Web Site', dashboardUser?.website ?? ''),
              const CustomDivider(),
              PostDetailItem('Email', dashboardUser?.email ?? ''),
              const CustomDivider(),
              PostDetailItem('Phone', dashboardUser?.phone ?? ''),
              const CustomDivider(),
              PostDetailItem(
                  'Post Body', dashboardPost?.body.substring(0, 25) ?? ''),
            ],
          ),
        ),
      ),
    ]);
  }
}
