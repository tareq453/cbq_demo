import 'package:cbq/data/remote/response/api_response.dart';
import 'package:cbq/data/remote/response/status.dart';
import 'package:cbq/models/post_details.dart';
import 'package:cbq/providers/post_details_provider.dart';
import 'package:cbq/ui/widgets/custom_error_widget.dart';
import 'package:cbq/ui/widgets/loading_widget.dart';
import 'package:cbq/ui/widgets/postDetails/post_details_content.dart';
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
    context.read<PostDetailsProvider>().fetchAndSetPostDetails(postID, userID);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Post Details"),
        ),
        body: Selector<PostDetailsProvider, ApiResponse<PostDetails>>(
          builder: (_, apiResponse, __) {
            switch (apiResponse.status) {
              case null:
              case Status.LOADING:
                return const LoadingWidget();
              case Status.COMPLETED:
                return PostDetailsContext(apiResponse.data);
              case Status.ERROR:
                return CustomErrorWidget(apiResponse.message);
            }
          },
          selector: (_, postDetailsProvider) => postDetailsProvider.apiResponse,
        ));
  }

}
