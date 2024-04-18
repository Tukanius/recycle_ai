part '../parts/result.dart';

class Filter {
  String? query;
  bool? isReceived;
  String? type;
  String? orderConfirmTerm;
  bool? isParent;

  Filter({
    this.isParent,
    this.type,
    this.query,
    this.isReceived,
    this.orderConfirmTerm,
  });
}

class Offset {
  int? page;
  int? limit;

  Offset({this.page, this.limit});
}

class ResultArguments {
  Filter? filter = Filter();
  Offset? offset = Offset(page: 1, limit: 10);
  int? page;
  int? limit;

  ResultArguments({this.filter, this.offset, this.page, this.limit});

  Map<String, dynamic> toJson() => _$ResultArgumentToJson(this);
}

class Result {
  List<dynamic>? rows = [];
  int? count = 0;
  int? notSeen = 0;

  Result({this.rows, this.count, this.notSeen});

  factory Result.fromJson(dynamic json, Function fromJson) =>
      _$ResultFromJson(json, fromJson);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
