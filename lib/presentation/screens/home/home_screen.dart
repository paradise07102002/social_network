import 'package:flutter/material.dart';
import 'package:social_network/presentation/components/post/post_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PostList();
  }
}
