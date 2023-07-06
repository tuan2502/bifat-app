import 'package:bifat_app/models/history_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HistoryDetailPage extends StatelessWidget {
  const HistoryDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
       final args = ModalRoute.of(context)?.settings.arguments;
       print('history: $args');
    // Data history = 
    return const Placeholder();
  }
}