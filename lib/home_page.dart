import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'boasvindas_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();
  double _resultadoIMC = 0.0;
  String _resultadoTexto = '';

  void _calcularIMC() {
    double peso = double.parse(_pesoController.text);
    double altura = double.parse(_alturaController.text);

    if (peso > 0 && altura > 0) {
      setState(() {
        _resultadoIMC = peso / (altura * altura);
        _resultadoTexto = _classificarIMC(_resultadoIMC);
      });
    }
  }

  String _classificarIMC(double imc) {
    if (imc < 18.5) {
      return 'Abaixo do peso';
    } else if (imc >= 18.5 && imc < 24.9) {
      return 'Peso normal';
    } else if (imc >= 25.0 && imc < 29.9) {
      return 'Sobrepeso';
    } else {
      return 'Obesidade';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                bool exitPressed = await exit();
                if (exitPressed) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BoasVindasPage(),
                      ));
                }
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Sair'),
            ),
            const SizedBox(height: 24.0),
            TextField(
              controller: _pesoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Peso (kg)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _alturaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Altura (m)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: _calcularIMC,
              child: const Text('Calcular IMC'),
            ),
            const SizedBox(height: 24.0),
            Text(
              _resultadoIMC == 0.0
                  ? 'Informe seus dados'
                  : 'Seu IMC é: ${_resultadoIMC.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 16.0),
            Text(
              _resultadoTexto,
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> exit() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    return true;
  }
}
