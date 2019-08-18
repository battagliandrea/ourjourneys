import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'package:our_journeys/injection/dependency_injection.dart';
import 'package:our_journeys/domain/usecase/usecase.dart';

import 'package:our_journeys/presentation/bloc/postlist/postlist.dart';


class PostBloc extends Bloc<PostEvent, PostState> {

  @override
  PostState get initialState => PostUninitialized();

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if(event is Fetch){
      try{
        if (currentState is PostUninitialized) {
          var posts = await new FetchPostsUseCase(Injector.providePostRepository()).fetchPosts();
          yield PostLoaded(posts);
        }
      } catch(_){
        yield PostError();
      }
    }
  }
}