import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/widgets/expenses.dart';

void main() {
  runApp(ExpensesApp(
      child: ExpensesApp(child: App())
    ));
}

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ExpensesApp.of(context).themeMode,
      builder: (context, theme, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark(useMaterial3: true),
        theme: ThemeData.light(useMaterial3: true),
        themeMode: theme,
        home: const Expenses(),
      ),
    );
  }
}

class ExpensesApp extends InheritedWidget {
  ExpensesApp({super.key, required super.child});

  final ValueNotifier<ThemeMode> themeMode = ValueNotifier(ThemeMode.light);
  
  static ExpensesApp? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ExpensesApp>();
  }

  void updateTheme(ThemeMode theme) => themeMode.value = theme;

  static ExpensesApp of(BuildContext context) {
    final ExpensesApp? result = maybeOf(context);
    assert(result != null, 'No ExpensesApp found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ExpensesApp oldWidget) =>
    oldWidget.themeMode != themeMode;
}
