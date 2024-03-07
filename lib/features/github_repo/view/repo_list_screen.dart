import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_101/features/github_repo/bloc/github_search_bloc.dart';
import 'package:flutter_task_101/features/github_repo/bloc/github_search_event.dart';
import 'package:flutter_task_101/features/github_repo/repository/github_repository.dart';
import 'package:flutter_task_101/features/github_repo/view/repo_body.dart';

class RepoListScreen extends StatelessWidget {
  const RepoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Github Search')),
      body: BlocProvider(
        create: (_) => GithubSearchBloc(
          githubRepository: context.read<GithubRepository>(),
        )..add(const RepoFetched()),
        child: const RepoBody(),
      ),
    );
  }
}
