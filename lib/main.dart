import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CounterProvider(
      counter: CounterModel(),
      child: const MaterialApp(
        home: CounterScreen(),
      ),
    );
  }
}

// 1️⃣ Tạo lớp model
class CounterModel {
  int value = 0;
  void increment() => value++;
}

// 2️⃣ Tạo InheritedWidget
class CounterProvider extends InheritedWidget {
  final CounterModel counter;

  const CounterProvider({
    required this.counter,
    required super.child,
    super.key,
  });

  static CounterProvider of(BuildContext context) {
    // dependOnInheritedWidgetOfExactType giúp rebuild khi dữ liệu thay đổi
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>()!;
  }

  @override
  bool updateShouldNotify(CounterProvider oldWidget) {
    // Chỉ rebuild khi dữ liệu khác
    return counter != oldWidget.counter;
  }
}

// 3️⃣ UI chính
class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});
  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  @override
  Widget build(BuildContext context) {
    final counter = CounterProvider.of(context).counter;

    return Scaffold(
      appBar: AppBar(title: const Text('InheritedWidget Demo')),
      body: Center(
        child: Text(
          'Giá trị: ${counter.value}',
          style: const TextStyle(fontSize: 24),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            counter.increment();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
