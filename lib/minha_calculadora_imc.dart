import 'package:calculadora_imc/alert_message.dart';
import 'package:calculadora_imc/botao_calcular_imc.dart';
import 'package:calculadora_imc/info_imc.dart';
import 'package:calculadora_imc/input.dart';
import 'package:flutter/material.dart';

class CalculadoraImc extends StatefulWidget {
  const CalculadoraImc({super.key});

  @override
  State<CalculadoraImc> createState() => _CalculadoraImcState();
}

class _CalculadoraImcState extends State<CalculadoraImc> {
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController alturaController = TextEditingController();

  double _valorPeso = 50;
  double _valorAltura = 1.6;

  double? imc;
  String? classificacao;
  Color? corResultado;

  @override
  void initState() {
    super.initState();
    _updateControllers();
  }

  @override
  void dispose() {
    pesoController.dispose();
    alturaController.dispose();
    super.dispose();
  }

  void _updateControllers() {
    pesoController.text = _valorPeso.toStringAsFixed(2);
    alturaController.text = _valorAltura.toStringAsFixed(2);
  }

  void _updateValue(String type, double value) {
    setState(() {
      if (type == 'peso') {
        _valorPeso = value;
      } else if (type == 'altura') {
        _valorAltura = value;
      }
      _updateControllers();
    });
  }

  void _calcularIMC() {
    final peso = double.tryParse(pesoController.text) ?? 0;
    final altura = double.tryParse(alturaController.text) ?? 0;

    if (peso <= 0 || altura <= 0) {
      // Mostrar uma mensagem de erro ao usuário
      return;
    }

    setState(() {
      imc = peso / (altura * altura);
      classificacao = getClassificacaoImc(imc);
      corResultado = getCorImc(imc);
    });
  }

  String getClassificacaoImc(double? imc) {
    if (imc == null) return 'Inválido';
    if (imc < 18.5) return 'Abaixo do Peso';
    if (imc <= 24.9) return 'Peso Normal';
    if (imc <= 29.9) return 'Sobrepeso';
    if (imc <= 34.9) return 'Obesidade Grau I';
    if (imc <= 39.9) return 'Obesidade Grau II';
    return 'Obesidade Grau III';
  }

  Color getCorImc(double? imc) {
    if (imc == null) return Colors.grey;
    if (imc < 18.5) return Colors.blue;
    if (imc <= 24.9) return Colors.lightGreen;
    if (imc <= 29.9) return Colors.orange;
    if (imc <= 34.9) return Colors.orangeAccent;
    if (imc <= 39.9) return Colors.redAccent;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              imc == null
                  ? const AlertMessage()
                  : InfoImc(
                      corResultado: corResultado,
                      imc: imc,
                      classificacao: classificacao,
                    ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AjusteValoresInput(
                    label: 'Seu Peso',
                    sufixoLabel: 'kg',
                    width: 85,
                    controller: pesoController,
                    onChanged: (peso) => _updateValue('peso', peso),
                    value: _valorPeso,
                    valorMinimo: 20,
                    valorMaximo: 300,
                    divisions: 280,
                  ),
                  const SizedBox(width: 22),
                  AjusteValoresInput(
                    label: 'Sua altura',
                    sufixoLabel: 'm',
                    width: 85,
                    controller: alturaController,
                    onChanged: (altura) => _updateValue('altura', altura),
                    value: _valorAltura,
                    valorMinimo: 0.5,
                    valorMaximo: 3.0,
                    divisions: 250,
                  ),
                ],
              ),
              const SizedBox(height: 22),
              BotaoCalcularImc(onPressed: _calcularIMC),
            ],
          ),
        ),
      ),
    );
  }
}
