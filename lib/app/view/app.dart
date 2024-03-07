import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_task_101/features/github_repo/repository/github_cache.dart';
import 'package:flutter_task_101/features/github_repo/repository/github_repository.dart';
import 'package:flutter_task_101/features/github_repo/view/repo_list_screen.dart';
import 'package:flutter_task_101/l10n/l10n.dart';
import 'package:flutter_task_101/shared/remote/api_service.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => ApiService(dotenv.env['BASE_URL']!),
        ),
        RepositoryProvider(create: (context) => GithubCache()),
        RepositoryProvider(
          create: (context) => GithubRepository(
            context.read<GithubCache>(),
            context.read<ApiService>(),
          ),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const RepoListScreen(),
      ),
    );
  }
}
