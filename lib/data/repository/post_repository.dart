import 'dart:async';

import 'package:our_journeys/data/datasource/remote_datasource.dart';
import 'package:our_journeys/presentation/model/post.dart';



abstract class PostRepository {
  Future<List<Post>> fetchPosts();
}

class PostRepositoryImpl implements PostRepository {

  RemoteDataSource remoteDataSource;

  PostRepositoryImpl(RemoteDataSource remoteDataSource) {
    this.remoteDataSource = remoteDataSource;
  }

  @override
  Future<List<Post>> fetchPosts() async {
    List<Post> users = await remoteDataSource.fetchPosts();

    if (users.length > 0) {
      return users;
    } else {
      return new List<Post>();
    }
  }
}