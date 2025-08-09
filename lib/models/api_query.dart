class ApiQuery {
  final int page;
  final int pageSize;
  final List<String>? sort;
  final Map<String, Map<String, dynamic>>? filter;

  ApiQuery({
    this.page = 1,
    this.pageSize = 10,
    this.sort,
    this.filter,
  });

  Map<String, dynamic> toQueryParameters() {
    final params = <String, dynamic>{
      'page': page.toString(),
      'pageSize': pageSize.toString(),
    };

    if (sort != null && sort!.isNotEmpty) {
      params['sort'] = sort!.join(',');
    }

    if (filter != null && filter!.isNotEmpty) {
      filter!.forEach((field, ops) {
        ops.forEach((op, value) {
          if (op == 'eq') {
            params['filter[$field]'] = value;
          } else {
            params['filter[$field][$op]'] = value;
          }
        });
      });
    }

    return params;
  }

  ApiQuery copyWith({
    int? page,
    int? pageSize,
    List<String>? sort,
    Map<String, Map<String, dynamic>>? filter,
  }) {
    return ApiQuery(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      sort: sort ?? this.sort,
      filter: filter ?? this.filter,
    );
  }
}
