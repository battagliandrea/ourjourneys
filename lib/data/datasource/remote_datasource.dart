import 'dart:async';
import 'dart:io';

import 'package:our_journeys/data/mapper/post_mapper.dart';
import 'package:our_journeys/data/model/model_remote_post.dart';
import 'package:our_journeys/framework/http/client.dart';
import 'package:our_journeys/presentation/model/post.dart';


class RemoteDataSource{
  Client _client = new Client(baseUrl: "https://jsonplaceholder.typicode.com");
  String endpoint = "/posts";

  RemoteDataSource({Client client}) {
    _client = client != null ? client : _client;
  }

  Future<List<Post>> fetchPosts() async {
    try {
      Uri url = Uri.parse(_client.baseUrl + endpoint);
      List <dynamic> res = await this._client.get(url);
      List<RemotePost> posts = res
          .map((p) => new RemotePost.fromMap(p))
          .toList();
      return PostMapper.transform(posts);
    } on HttpException catch (e) {
      return [];
    } catch (err) {
      return [];
    }
  }
}