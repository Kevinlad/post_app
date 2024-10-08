import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knovator_task/Screens/post_detail_screen.dart';

import '../controllers/posts_controller.dart';
import '../model/posts_model.dart';

class PostListScreen extends StatelessWidget {
  final PostController postController = Get.put(PostController());

  PostListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: Obx(() {
        if (postController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: postController.posts.length,
            itemBuilder: (context, index) {
              final post = postController.posts[index];
              return GestureDetector(
                  onTap: () {
                    postController.markPostAsRead(post.id ?? 0);
                    print(post.id);
                    Get.to(() => PostDetailScreen(postId: post.id!));
                  },
                  child: PostTile(post: postController.posts[index]));
            },
          );
        }
      }),
    );
  }
}

class PostTile extends StatelessWidget {
  final Post post;

  PostTile({required this.post});
  int getRandomTimerDuration() {
    final random = Random();
    return random.nextInt(21) + 10; // Random number between 10 and 30 seconds
  }

  @override
  Widget build(BuildContext context) {
    final int duration = getRandomTimerDuration();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: post.isRead
            ? Colors.white
            : Colors.yellow[100], // Light yellow background color
        // padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.title ?? "",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              const SizedBox(height: 6.0),
              Text(post.body ?? ""),
              const SizedBox(height: 6.0),
              Row(
                children: [
                  const Icon(Icons.timer, color: Colors.grey),
                  const SizedBox(width: 4.0),
                  Text('$duration s',
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
