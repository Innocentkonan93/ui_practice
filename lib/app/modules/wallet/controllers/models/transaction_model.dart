import 'package:flutter/material.dart';

class Transaction {
  final String id;
  final String userId;
  final String userName;
  final String receiver;
  final double amount;
  final String currency;
  final String status;
  final DateTime date;
  final Color color;

  Transaction({
    required this.id,
    required this.userId,
    required this.userName,
    required this.receiver,
    required this.amount,
    required this.currency,
    required this.status,
    required this.date,
    required this.color,
  });
}

List<Transaction> dummyTransactions = [
  Transaction(
    id: '1',
    userId: '101',
    userName: 'Alice',
    receiver: 'David',
    amount: 200.0,
    currency: 'USD',
    status: 'completed',
    date: DateTime.now().subtract(const Duration(days: 1)),
    color: Colors.green,
  ),
  Transaction(
    id: '2',
    userId: '102',
    userName: 'Bob',
    receiver: 'Emma',
    amount: 75.0,
    currency: 'EUR',
    status: 'pending',
    date: DateTime.now().subtract(const Duration(days: 2)),
    color: Colors.orange,
  ),
  Transaction(
    id: '3',
    userId: '103',
    userName: 'Charlie',
    receiver: 'Frank',
    amount: 150.5,
    currency: 'GBP',
    status: 'failed',
    date: DateTime.now().subtract(const Duration(days: 3)),
    color: Colors.red,
  ),
];
