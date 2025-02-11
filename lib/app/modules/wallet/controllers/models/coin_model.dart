import 'package:flutter/material.dart';

class Coin {
  final String id;
  final String name;
  final String symbol;
  final double price;
  final double change;
  final String imageUrl;
  final Color color;

  Coin({
    required this.id,
    required this.name,
    required this.symbol,
    required this.price,
    required this.change,
    required this.imageUrl,
    required this.color,
  });
}

List<Coin> dummyCoins = [
  Coin(
    id: '1',
    name: 'Bitcoin',
    symbol: 'BTC',
    price: 50000.0,
    change: 2.5,
    imageUrl: 'assets/icons/coins/btc.png',
    color: const Color(0xFFF7931A),
  ),
  Coin(
    id: '2',
    name: 'Ethereum',
    symbol: 'ETH',
    price: 3500.0,
    change: -1.2,
    imageUrl: 'assets/icons/coins/eth.png',
    color: const Color(0xFF0033AD),
  ),
  Coin(
    id: '3',
    name: 'Binance Coin',
    symbol: 'BNB',
    price: 450.0,
    change: 0.8,
    imageUrl: 'assets/icons/coins/bnb.png',
    color: const Color(0xFFF3BA2F),
  ),
  Coin(
    id: '4',
    name: 'Cardano',
    symbol: 'ADA',
    price: 1.2,
    change: 3.1,
    imageUrl: 'assets/icons/coins/ada.png',
    color: const Color(0xFF3C3C3D),
  ),
  Coin(
    id: '5',
    name: 'Solana',
    symbol: 'SOL',
    price: 150.0,
    change: -2.7,
    imageUrl: 'assets/icons/coins/sol.png',
    color: const Color(0xFF00AEEF),
  ),
];
