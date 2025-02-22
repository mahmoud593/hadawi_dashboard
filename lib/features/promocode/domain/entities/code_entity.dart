class CodeEntity {
  final String id;
  final int discount;
  final String code;
  final int used;
  final int maxUsage;
  final String expiryDate;
  final List<String> occasions;

  CodeEntity({
    required this.id,
    required this.discount,
    required this.code,
    required this.used,
    required this.maxUsage,
    required this.expiryDate,
    required this.occasions,
  });
}
