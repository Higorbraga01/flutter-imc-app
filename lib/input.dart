import 'package:flutter/material.dart';

class AjusteValoresInput extends StatelessWidget {
  const AjusteValoresInput({
    super.key,
    required this.label,
    required this.controller,
    required this.onChanged,
    required this.value,
    required this.width,
    required this.valorMinimo,
    required this.valorMaximo,
    required this.sufixoLabel,
    this.divisions, // Adicionado para granularidade do Slider
  });

  final String label;
  final TextEditingController controller;
  final void Function(double) onChanged;
  final double value;
  final double width;
  final double valorMinimo;
  final double valorMaximo;
  final String sufixoLabel;
  final int? divisions;

  @override
  Widget build(BuildContext context) {
    assert(value >= valorMinimo && value <= valorMaximo,
        'O valor inicial deve estar dentro do intervalo mínimo e máximo.');

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(label),
          SizedBox(height: 6),
          SizedBox(
            width: width,
            child: TextField(
              enabled: false,
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                suffixText: sufixoLabel,
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          SizedBox(height: 12),
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 1.5,
              activeTickMarkColor: Colors.purple,
            ),
            child: Slider(
              activeColor: Colors.purple,
              value: value,
              onChanged: onChanged,
              min: valorMinimo,
              max: valorMaximo,
              divisions: divisions, // Adicionado para granularidade
              label: value.toStringAsFixed(2),
            ),
          ),
        ],
      ),
    );
  }
}
