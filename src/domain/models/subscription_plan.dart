class SubscriptionPlan {
  final String id;
  final String name;
  final double price;
  final Duration duration;
  final String description;
  final bool isTrial;
  final bool isActive;

  const SubscriptionPlan({
    required this.id,
    required this.name,
    required this.price,
    required this.duration,
    required this.description,
    this.isTrial = false,
    this.isActive = true,
  });

  // Пример сериализации для Firestore
  factory SubscriptionPlan.fromMap(Map<String, dynamic> map) {
    return SubscriptionPlan(
      id: map['id'] as String,
      name: map['name'] as String,
      price: (map['price'] as num).toDouble(),
      duration: Duration(days: map['durationDays'] as int),
      description: map['description'] as String,
      isTrial: map['isTrial'] ?? false,
      isActive: map['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'price': price,
    'durationDays': duration.inDays,
    'description': description,
    'isTrial': isTrial,
    'isActive': isActive,
  };
}
