import 'package:equatable/equatable.dart';

import 'package:our_journeys/presentation/model/model.dart';
import 'package:our_journeys/presentation/model/post.dart';

abstract class PostState extends Equatable {
  PostState([List props = const []]) : super(props);
}

class PostUninitialized extends PostState {
  @override
  String toString() => "PostUninitialized";
}

class PostError extends PostState {
  @override
  String toString() => "PostError";
}

class PostLoaded extends PostState {
  final List<Post> posts;

  PostLoaded(this.posts) : super(posts);

  PostLoaded copyWith({
    List<Post> posts,
  }){
    return PostLoaded(posts ?? this.posts);
  }
}
