

import 'package:our_journeys/data/model/model_remote_post.dart';
import 'package:our_journeys/presentation/model/post.dart';

class PostMapper {

  static List<Post> transform(List<RemotePost> resultSource) {
    List<Post> resultList = new List<Post>();
    if (resultSource != null) {
    resultSource.forEach((u) => resultList.add(new Post(u)));
    }
    return resultList;
  }

}