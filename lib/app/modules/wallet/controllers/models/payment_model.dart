import 'package:flutter/material.dart';

class Payment {
  final String id;
  final String userId;
  final double amount;
  final String currency;
  final String status;
  final DateTime date;
  final Color color;
  final bool isPremium;

  Payment({
    required this.id,
    required this.userId,
    required this.amount,
    required this.currency,
    required this.status,
    required this.date,
    required this.color,
    required this.isPremium,
  });
}

List<Payment> dummyPayments = [
  Payment(
    id: '1',
    userId: '101',
    amount: 200.0,
    currency: 'USD',
    status: 'completed',
    date: DateTime.now().subtract(const Duration(days: 1)),
    color: Colors.green,
    isPremium: true,
  ),
  Payment(
    id: '2',
    userId: '102',
    amount: 75.0,
    currency: 'EUR',
    status: 'pending',
    date: DateTime.now().subtract(const Duration(days: 2)),
    color: Colors.orange,
    isPremium: false,
  ),
  Payment(
    id: '3',
    userId: '103',
    amount: 150.5,
    currency: 'GBP',
    status: 'failed',
    date: DateTime.now().subtract(const Duration(days: 3)),
    color: Colors.red,
    isPremium: false,
  ),
];
