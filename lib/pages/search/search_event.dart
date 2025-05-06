sealed class SearchEvent {}

class GetSetStateSearch extends SearchEvent {
  final String query;

  GetSetStateSearch({required this.query});
}
