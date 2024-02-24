import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/main.dart';
import 'package:flutter_expense_tracker_app/widgets/chart/chart.dart';
import 'package:flutter_expense_tracker_app/widgets/expense_form.dart';
import 'package:flutter_expense_tracker_app/widgets/expenses-list/expenses_list.dart';
import 'package:flutter_expense_tracker_app/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [];
  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final index = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense deleted.'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(label: 'Undo', onPressed: () {
          setState(() {
            _registeredExpenses.insert(index, expense);
          });
        })
      )
    );
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      context: context,
      barrierLabel: 'Add Expenses',
      isScrollControlled: true,
      builder: (ctx) {
        return ExpenseForm(
          onSubmit: _addExpense,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.document_scanner_sharp,
            size: 80,
            color: Colors.blue.shade300,
          ),
          const SizedBox(height: 20),
          const Text('No expenses found. Start adding some!', style: TextStyle(fontSize: 18),)
        ],
      )
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(
            child: ExpensesList(
            expenses: _registeredExpenses,
            onRemove: _removeExpense,
          )
          )
        ],
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
        actions: [
          IconButton(
            onPressed: (){
              // Switch Theme
              ExpensesApp.of(context).updateTheme(ExpensesApp.of(context).themeMode.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
            },
            icon: Icon(ExpensesApp.of(context).themeMode.value == ThemeMode.light ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
          ),
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: mainContent,
    );
  }
}
