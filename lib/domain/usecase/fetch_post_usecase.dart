import 'dart:async';

import 'package:our_journeys/data/repository/post_repository.dart';
import 'package:our_journeys/presentation/model/post.dart';

class FetchPostsUseCase {
  PostRepository postRepository;

  FetchPostsUseCase(PostRepository postRepository) {
    this.postRepository = postRepository;
  }

  Future<List<Post>> fetchPosts() async {
   return await postRepository.fetchPosts();
  }
}