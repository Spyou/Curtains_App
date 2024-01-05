class Currency {
  final String? code;
  final String? name;
  final String? date;
  final String? rate;

  Currency({
    required this.code,
    required this.name,
    required this.date,
    required this.rate,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      code: json['code']??"",
      name: json['CcyNm_UZ']??"",
      date: json['Date']??"",
      rate: json['Rate'] != null ? json['Rate'] : "", // Handling null case
    );
  }
}
