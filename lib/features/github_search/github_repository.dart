import 'dart:async';

import 'package:flutter_task_101/features/github_search/github_cache.dart';
import 'package:flutter_task_101/features/github_search/github_client.dart';
import 'package:flutter_task_101/features/github_search/models/models.dart';

class GithubRepository {
  const GithubRepository(this.cache, this.client);

  final GithubCache cache;
  final GithubClient client;

  Future<SearchResult> search(String term) async {
    final cachedResult = cache.get(term);
    if (cachedResult != null) {
      return cachedResult;
    }
    final result = await client.search(term);
    cache.set(term, result);
    return result;
  }
}
