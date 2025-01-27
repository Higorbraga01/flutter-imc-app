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
  late TextEditingController pesoController;
  late TextEditingController alturaController;
  double _valorPeso = 50;
  double _valorAltura = 1.6;

  double? imc;
  String? classificacao;
  Color? corResultado;

  @override
  void initState() {
    pesoController = TextEditingController(text: _valorPeso.toString());
    alturaController = TextEditingController(text: _valorAltura.toString());
    super.initState();
  }

  @override
  void dispose() {
    pesoController.dispose();
    alturaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            imc == null
                ? AlertMessage()
                : InfoImc(
                    corResultado: corResultado,
                    imc: imc,
                    classificacao: classificacao),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AjusteValoresInput(
                  label: 'Seu Peso',
                  sufixoLabel: 'kg',
                  width: 85,
                  controller: pesoController,
                  onChanged: (peso) {
                    setState(() {
                      _valorPeso = peso;
                      pesoController.text = _valorPeso.toStringAsFixed(2);
                    });
                  },
                  value: _valorPeso,
                  valorMinimo: 20,
                  valorMaximo: 300,
                  divisions: 280,
                ),
                SizedBox(
                  width: 22,
                ),
                AjusteValoresInput(
                    label: 'Sua altura',
                    sufixoLabel: 'm',
                    width: 85,
                    controller: alturaController,
                    onChanged: (altura) {
                      setState(() {
                        _valorAltura = altura;
                        alturaController.text = _valorAltura.toStringAsFixed(2);
                      });
                    },
                    value: _valorAltura,
                    valorMinimo: 0.5,
                    valorMaximo: 3.0,
                    divisions: 250),
              ],
            ),
            SizedBox(
              height: 22,
            ),
            BotaoCalcularImc(onPressed: () {
              double peso = pesoController.text != ''
                  ? double.parse(pesoController.text)
                  : 0;
              double altura = alturaController.text != ''
                  ? double.parse(alturaController.text)
                  : 0;
              setState(() {
                imc = peso / (altura * altura);
                classificacao = getClassificacaoImc(imc);
                corResultado = getCorImc(imc);
              });
            })
          ],
        ),
      ),
    );
  }

  String getClassificacaoImc(double? imc) {
    if (imc! < 18.5) {
      return 'Abaixo do Peso';
    } else if (imc > 18.5 && imc < 24.9) {
      return 'Peso Normal';
    } else if (imc > 25.0 && imc < 29.9) {
      return 'Sobrepeso';
    } else if (imc > 30.0 && imc < 34.9) {
      return 'Obesidade Grau I';
    } else if (imc > 35.0 && imc < 39.9) {
      return 'Obesidade Grau II';
    } else {
      return 'Obesidade Grau III';
    }
  }

  Color getCorImc(double? imc) {
    if (imc! < 18.5) {
      return Colors.blue;
    } else if (imc > 18.5 && imc < 24.9) {
      return Colors.lightGreen;
    } else if (imc > 25.0 && imc < 29.9) {
      return Colors.orange;
    } else if (imc > 30.0 && imc < 34.9) {
      return Colors.orangeAccent;
    } else if (imc > 35.0 && imc < 39.9) {
      return Colors.redAccent;
    } else {
      return Colors.red;
    }
  }
}
