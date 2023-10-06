import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';
  bool _isResultCalculated = false;
  TextEditingController _searchController = TextEditingController();
  List<String> items = [
    'nuwan wasantha',
    'samitha',
    'janaka sir',
    'karunarathna',
    'asela ',
    'sampath',
    'danushka',
    'kavidu',
    'raj sir',
    'rbs softwer',
  ];

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _expression = '';
        _isResultCalculated = false;
      } else if (buttonText == '=') {
        if (!_isResultCalculated) {
          try {
            Parser p = Parser();
            Expression exp = p.parse(_expression);
            ContextModel cm = ContextModel();
            double result = exp.evaluate(EvaluationType.REAL, cm);
            _expression = result.toString();
            _isResultCalculated = true;
          } catch (e) {
            _expression = 'Error';
          }
        }
      } else if (buttonText == '.') {
        if (!_expression.contains('.')) {
          _expression += buttonText;
          _isResultCalculated = false;
        }
      } else if (buttonText == 'Cut') {
        if (_expression.isNotEmpty) {
          _expression = _expression.substring(0, _expression.length - 1);
        }
      } else {
        _expression += buttonText;
        _isResultCalculated = false;
      }
    });
  }

  Widget _buildButton(String buttonText, {Color color = Colors.black}) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            side: BorderSide(color: Colors.red),
          ),
          padding: EdgeInsets.all(24.0),
        ),
        onPressed: () => _onButtonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
      ),
    );
  }

  List<String> _filteredItems(String query) {
    return items
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KFD LANKA BIN MANAGEMENT SYSTEM'),
        centerTitle: true,
        leading: Image.asset(
          'assets/images/logo.png',
          width: 40.0,
          height: 40.0,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (query) {
                setState(() {}); // Trigger a rebuild on text change
              },
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredItems(_searchController.text).length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_filteredItems(_searchController.text)[index]),
                );
              },
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _expression,
                style: TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  _buildButton('7'),
                  _buildButton('8'),
                  _buildButton('9'),
                  _buildButton('/'),
                ],
              ),
              Row(
                children: [
                  _buildButton('4'),
                  _buildButton('5'),
                  _buildButton('6'),
                  _buildButton('*'),
                ],
              ),
              Row(
                children: [
                  _buildButton('1'),
                  _buildButton('2'),
                  _buildButton('3'),
                  _buildButton('-'),
                ],
              ),
              Row(
                children: [
                  _buildButton('C'),
                  _buildButton('0'),
                  _buildButton('.'),
                  _buildButton('+'),
                ],
              ),
              Row(
                children: [
                  _buildButton('Cut', color: Colors.red),
                  _buildButton('=', color: Colors.green),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
