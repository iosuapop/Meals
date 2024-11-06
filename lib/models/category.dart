import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Category {
  const Category({
    required this.id,
    required this.title,
    this.color = Colors.orange,
  });

  final String id;
  final String title;
  final Color color;

  factory Category.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final colorData = data['color'] as Map<String, dynamic>;

    return Category(
      id: doc.id,
      title: data['title'],
      color: Color.fromARGB(
        colorData['a'],
        colorData['r'],
        colorData['g'],
        colorData['b'],
      ),
    );
  }
}
