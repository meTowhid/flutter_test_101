import 'package:equatable/equatable.dart';

sealed class GithubSearchEvent extends Equatable {
  const GithubSearchEvent();
}

final class RepoFetched extends GithubSearchEvent {
  const RepoFetched();

  @override
  List<Object> get props => [];
}
