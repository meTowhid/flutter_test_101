
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_101/features/github_search/github_repository.dart';
import 'package:flutter_task_101/features/github_search/github_search_bloc/github_search_bloc.dart';
import 'package:flutter_task_101/features/github_search/view/search_form.dart';

class GithubSearch extends StatelessWidget {
  const GithubSearch({required this.githubRepository, super.key});

  final GithubRepository githubRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Github Search')),
      body: BlocProvider(
        create: (_) => GithubSearchBloc(githubRepository: githubRepository),
        child: const SearchForm(),
      ),
    );
  }
}