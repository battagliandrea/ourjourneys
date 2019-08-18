import 'package:our_journeys/data/model/model_remote_post.dart';
import 'package:our_journeys/data/mapper/mappers.dart';

class Post implements Convert<RemotePost, Post> {

  int userId;
  int id;
  String title;
  String body;

  Post(RemotePost fromModel) {
    userId = fromModel.userId;
    id = fromModel.id;
    title = fromModel.title;
    body = fromModel.body;
  }

  @override
  Post fromSourceModel(RemotePost fromModel) {
    return new Post(fromModel);
  }


}