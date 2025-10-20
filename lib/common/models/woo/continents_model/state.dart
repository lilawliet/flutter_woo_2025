class State {
  String? code;
  String? name;

  State({this.code, this.name});

  factory State.fromJson(Map<String, dynamic> json) {
    // 处理code可能是int或String的情况
    dynamic codeValue = json['code'];
    String? code;
    if (codeValue != null) {
      code = codeValue.toString();
    }

    return State(code: code, name: json['name'] as String?);
  }

  Map<String, dynamic> toJson() => {'code': code, 'name': name};
}
