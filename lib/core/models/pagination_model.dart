class PaginationModel<T> {
  final int currentPage;
  final int lastPage;
  final int total;
  final String? nextPageUrl;
  final List<T> items;

  PaginationModel({
    required this.currentPage,
    required this.lastPage,
    required this.total,
    required this.nextPageUrl,
    required this.items,
  });

  factory PaginationModel.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return PaginationModel(
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      total: json['total'],
      nextPageUrl: json['next_page_url'],
      items: (json['data'] as List).map((e) => fromJsonT(e)).toList(),
    );
  }

  bool get hasMore => currentPage < lastPage;
}
