class Expense {
  final String id;
  final String title;
  final String description;
  final double amount;
  final String paidBy;
  final List<String> splitBetween;
  final DateTime createdAt;
  final String category;
  final String? receipt;

  Expense({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.paidBy,
    required this.splitBetween,
    required this.createdAt,
    required this.category,
    this.receipt,
  });
}
