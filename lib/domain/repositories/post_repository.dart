import 'package:social_network/data/models/posts/post_model.dart';

abstract class PostRepository {
  Future<List<PostModel>> getAllPost(int page, int limit);
}
