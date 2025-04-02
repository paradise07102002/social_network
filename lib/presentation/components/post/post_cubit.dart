import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/data/models/posts/post_model.dart';
import 'package:social_network/data/repositories/post_repository.dart';

class PostCubit extends Cubit<List<PostModel>> {
  final PostRepository postRepository;
  int currentPage = 1;
  final int limit = 10;
  bool isLoading = false;

  PostCubit(this.postRepository) : super([]);

  void loadPosts() async {
    if (isLoading) return;
    isLoading = true;

    try {
      final newPosts = await postRepository.getAllPost(currentPage, limit);
      if (newPosts.isNotEmpty) {
        emit([...state, ...newPosts]);
        currentPage++;
      }
    } catch (e) {
      throw ("error: $e");
    } finally {
      isLoading = false;
    }
  }
}
