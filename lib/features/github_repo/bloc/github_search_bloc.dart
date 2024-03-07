import 'package:bloc/bloc.dart';
import 'package:flutter_task_101/features/github_repo/bloc/github_search_event.dart';
import 'package:flutter_task_101/features/github_repo/bloc/github_search_state.dart';
import 'package:flutter_task_101/features/github_repo/models/models.dart';
import 'package:flutter_task_101/features/github_repo/repository/github_repository.dart';
import 'package:rxdart/rxdart.dart';

const _duration = Duration(milliseconds: 300);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

class GithubSearchBloc extends Bloc<GithubSearchEvent, GithubSearchState> {
  GithubSearchBloc({required this.githubRepository})
      : super(SearchStateEmpty()) {
    // on<TextChanged>(_onTextChanged, transformer: debounce(_duration));
    on<RepoFetched>(_onFetch);
  }

  final GithubRepository githubRepository;

  Future<void> _onFetch(RepoFetched event,
      Emitter<GithubSearchState> emit) async {
    emit(SearchStateLoading());

    try {
      final results = await githubRepository.fetch();
      emit(SearchStateSuccess(results.items));
    } catch (error) {
      emit(
        error is SearchResultError
            ? SearchStateError(error.message)
            : const SearchStateError('something went wrong'),
      );
    }
  }
}