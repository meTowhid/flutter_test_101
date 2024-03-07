import 'package:bloc/bloc.dart';
import 'package:flutter_task_101/features/github_search/github_repository.dart';
import 'package:flutter_task_101/features/github_search/github_search_bloc/github_search_event.dart';
import 'package:flutter_task_101/features/github_search/github_search_bloc/github_search_state.dart';
import 'package:flutter_task_101/features/github_search/models/models.dart';
import 'package:rxdart/rxdart.dart';

const _duration = Duration(milliseconds: 300);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

class GithubSearchBloc extends Bloc<GithubSearchEvent, GithubSearchState> {
  GithubSearchBloc({required this.githubRepository})
      : super(SearchStateEmpty()) {
    on<TextChanged>(_onTextChanged, transformer: debounce(_duration));
  }

  final GithubRepository githubRepository;

  Future<void> _onTextChanged(
    TextChanged event,
    Emitter<GithubSearchState> emit,
  ) async {
    final searchTerm = event.text;

    if (searchTerm.isEmpty) return emit(SearchStateEmpty());

    emit(SearchStateLoading());

    try {
      final results = await githubRepository.search(searchTerm);
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
