import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/models/expense.dart';
import 'package:flutter_expense_tracker_app/widgets/expenses-list/expenses_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({Key? key, required this.expenses, required this.onRemove}) : super(key: key);

  final List<Expense> expenses;
  final void Function(Expense expense) onRemove; 

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expenses[index].title),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 4),
          margin: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 4,
          ),
          child: const Text('Remove'),
        ),
        onDismissed: (direction) => {
          onRemove(expenses[index])
        },
        child: ExpenseItem(
          expense: expenses[index],
        ),
      ),
    );
  }
}
