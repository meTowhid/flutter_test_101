import 'package:flutter/material.dart';
import 'package:flutter_task_101/features/github_search/github_cache.dart';
import 'package:flutter_task_101/features/github_search/github_client.dart';
import 'package:flutter_task_101/features/github_search/github_repository.dart';
import 'package:flutter_task_101/features/github_search/view/github_search.dart';
import 'package:flutter_task_101/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final githubRepository = GithubRepository(GithubCache(), GithubClient());

    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: GithubSearch(githubRepository: githubRepository),
    );
  }
}
