import '../models/data_layer.dart';
import 'package:flutter/material.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({Key? key}) : super(key: key);

  @override
  State createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  Plan plan = const Plan();

  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        FocusScope.of(context).requestFocus(FocusNode());
      });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rizky')),
      body: _buildList(),
      floatingActionButton: _buildAddTaskButton(),
    );
  }

  Widget _buildAddTaskButton() {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        setState(() {
          Task newTask = Task();
          plan = Plan(
            name: plan.name,
            tasks: List<Task>.from(plan.tasks)..add(newTask),
          );
        });
      },
    );
  }

  Widget _buildList() {
    return ListView.builder(
      controller: scrollController,
      keyboardDismissBehavior: Theme.of(context).platform == TargetPlatform.iOS
          ? ScrollViewKeyboardDismissBehavior.onDrag
          : ScrollViewKeyboardDismissBehavior.manual,
      itemCount: plan.tasks.length,
      itemBuilder: (context, index) => _buildTaskTile(plan.tasks[index], index),
    );
  }

  Widget _buildTaskTile(Task task, int index) {
    return ListTile(
      leading: Checkbox(
        value: task.complete,
        onChanged: (selected) => _onCheckboxChanged(selected, index),
      ),
      title: TextFormField(
        initialValue: task.description,
        onChanged: (text) => _onDescriptionChanged(text, index),
      ),
    );
  }

  void _onCheckboxChanged(bool? selected, int index) {
    setState(() {
      plan = Plan(
        name: plan.name,
        tasks: List<Task>.from(plan.tasks)
          ..[index] = Task(
            description: plan.tasks[index].description,
            complete: selected ?? false,
          ),
      );
    });
  }

  void _onDescriptionChanged(String text, int index) {
    setState(() {
      plan = Plan(
        name: plan.name,
        tasks: List<Task>.from(plan.tasks)
          ..[index] = Task(
            description: text,
            complete: plan.tasks[index].complete,
          ),
      );
    });
  }
}