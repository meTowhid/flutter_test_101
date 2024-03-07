import 'dart:async';

import 'package:flutter_task_101/features/github_repo/models/models.dart';
import 'package:flutter_task_101/features/github_repo/repository/github_cache.dart';
import 'package:flutter_task_101/shared/remote/api_service.dart';

class GithubRepository {
  const GithubRepository(this.cache, this.client);

  final GithubCache cache;
  final ApiService client;

  Future<SearchResult> fetch() async {
    final cachedResult = cache.get('flutter');
    if (cachedResult != null) return cachedResult;
    try {
      final response =
          await client.get('/search/repositories', {'q': 'flutter'});
      final result = SearchResult.fromJson(response);
      cache.set('flutter', result);
      return result;
    } catch (e) {
      throw SearchResultError.fromJson({'message': 'Failed to load data'});
    }
  }
}
