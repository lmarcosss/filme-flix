sealed class SearchEvent {}

class GetSetStateSearch extends SearchEvent {
  final String query;
  final bool isLoadMore;

  GetSetStateSearch({
    required this.query,
    this.isLoadMore = false,
  });
}
