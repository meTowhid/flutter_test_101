import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_101/features/github_repo/bloc/github_search_bloc.dart';
import 'package:flutter_task_101/features/github_repo/bloc/github_search_state.dart';
import 'package:flutter_task_101/features/github_repo/models/models.dart';
import 'package:url_launcher/url_launcher.dart';

class RepoBody extends StatelessWidget {
  const RepoBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<GithubSearchBloc, GithubSearchState>(
        builder: (context, state) {
          return switch (state) {
            SearchStateEmpty() => const Text('Please enter a term to begin'),
            SearchStateLoading() => const CircularProgressIndicator.adaptive(),
            SearchStateError() => Text(state.error),
            SearchStateSuccess() => state.items.isEmpty
                ? const Text('No Results')
                : RepoResults(items: state.items),
          };
        },
      ),
    );
  }
}

class RepoResults extends StatelessWidget {
  const RepoResults({required this.items, super.key});

  final List<SearchResultItem> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return RepoResultItem(item: items[index]);
      },
    );
  }
}

class RepoResultItem extends StatelessWidget {
  const RepoResultItem({required this.item, super.key});

  final SearchResultItem item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Image.network(item.owner.avatarUrl)),
      onTap: () => launchUrl(Uri.parse(item.htmlUrl)),
      title: Text(item.fullName),
    );
  }
}
