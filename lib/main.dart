import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading = false;

  Future<void> _loadBundle() async {
    if (_isLoading) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    // At least 1 frame were dropped with the load call.
    await rootBundle.loadString('assets/large-data.json');
    _isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: Text('Load bundle test')),
        body: Stack(
          children: <Widget>[
            const Center(
              child: Text('Loading the bundle will cause frames lost.'),
            ),
            if (_isLoading) const Center(child: CircularProgressIndicator()),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _loadBundle,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
