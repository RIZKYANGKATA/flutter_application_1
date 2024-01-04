import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/plan.dart';
import '/views/plan_screen.dart';
import '/provider/plan_provider.dart';
import '/views/plan_creator_screen.dart';

void main() => runApp(MasterPlanApp());

class MasterPlanApp extends StatelessWidget {
  const MasterPlanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return PlanProvider(
      notifier: ValueNotifier<List<Plan>>(const []),
      child: MaterialApp(
        title: 'State management app',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: const PlanCreatorScreen(),
      ),
    );
  }
}