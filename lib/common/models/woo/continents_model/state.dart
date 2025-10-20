class State {
  int? code;
  String? name;

  State({this.code, this.name});

  factory State.fromJson(Map<String, dynamic> json) =>
      State(code: json['code'] as int?, name: json['name'] as String?);

  Map<String, dynamic> toJson() => {'code': code, 'name': name};
}
