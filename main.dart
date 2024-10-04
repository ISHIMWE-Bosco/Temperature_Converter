import 'package:flutter/material.dart';

void main() {
  runApp(TemperatureConverterApp());
}

class TemperatureConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto', // Custom font
      ),
      home: TemperatureConverter(),
    );
  }
}

class TemperatureConverter extends StatefulWidget {
  @override
  _TemperatureConverterState createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  String _selectedConversion = 'F to C'; // Default conversion
  double _inputValue = 0.0;
  String _result = '';
  List<String> _history = [];

  final TextEditingController _controller = TextEditingController();

  // Function to convert temperature
  void _convert() {
    setState(() {
      double value = double.tryParse(_controller.text) ?? 0.0;
      double convertedValue;

      if (_selectedConversion == 'F to C') {
        convertedValue = (value - 32) * 5 / 9;
        _result = '${convertedValue.toStringAsFixed(2)} °C';
        _history.add('F to C: $value => ${convertedValue.toStringAsFixed(2)}');
      } else {
        convertedValue = value * 9 / 5 + 32;
        _result = '${convertedValue.toStringAsFixed(2)} °F';
        _history.add('C to F: $value => ${convertedValue.toStringAsFixed(2)}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Converter'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF607D8B), Color(0xFFB0BEC5)], // Greyish blue gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Conversion selection (radio buttons)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<String>(
                  value: 'F to C',
                  groupValue: _selectedConversion,
                  onChanged: (value) {
                    setState(() {
                      _selectedConversion = value!;
                    });
                  },
                  activeColor: Colors.white,
                ),
                Text('F to C', style: TextStyle(color: Colors.white)),
                SizedBox(width: 20),
                Radio<String>(
                  value: 'C to F',
                  groupValue: _selectedConversion,
                  onChanged: (value) {
                    setState(() {
                      _selectedConversion = value!;
                    });
                  },
                  activeColor: Colors.white,
                ),
                Text('C to F', style: TextStyle(color: Colors.white)),
              ],
            ),
            SizedBox(height: 20),

            // Input for temperature (moved below radio buttons)
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter Temperature',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white),
                ),
                filled: true,
                fillColor: Colors.white24,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),

            // Convert button
            Center(
              child: ElevatedButton(
                onPressed: _convert,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Changed to green
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text('Convert', style: TextStyle(fontSize: 18)),
              ),
            ),
            SizedBox(height: 20),

            // Result display
            Center(
              child: Text(
                _result,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),

            // Conversion history
            Text(
              'Conversion History',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                  itemCount: _history.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        _history[index],
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
