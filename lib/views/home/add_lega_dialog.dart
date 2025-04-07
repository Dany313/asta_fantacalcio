import 'package:asta_fantacalcio/config/costants.dart';
import 'package:asta_fantacalcio/validators/string_validator.dart';
import 'package:flutter/material.dart';

class AddLegaDialog extends StatefulWidget {
  final Function(String nome, int budget) onAdd;

  const AddLegaDialog({
    super.key,
    required this.onAdd,
  });

  @override
  State<AddLegaDialog> createState() => _AddLegaDialogState();
}

class _AddLegaDialogState extends State<AddLegaDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nomeController = TextEditingController();
  int selectedBudget = maxBudgetOptions[0];

  @override
  void dispose() {
    nomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'AGGIUNGI LEGA',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            TextFormField(
              controller: nomeController,
              decoration: const InputDecoration(
                hintText: 'Inserisci il nome della lega',
              ),
              // Usa il validatore composito
              validator: (value) => ValidatorString.isNotEmpty.validate(value),
              // Converti automaticamente in maiuscolo
              onChanged: (value) {
                final upperValue = value.toUpperCase();
                if (value != upperValue) {
                  nomeController.value = nomeController.value.copyWith(
                    text: upperValue,
                    selection: TextSelection.collapsed(offset: upperValue.length),
                  );
                }
              },
            ),
            const SizedBox(height: 16),
            Text(
              'BUDGET MASSIMO:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            ...maxBudgetOptions.map((budget) => RadioListTile<int>(
              title: Text(budget.toString()),
              value: budget,
              groupValue: selectedBudget,
              onChanged: (value) {
                setState(() {
                  selectedBudget = value!;
                });
              },
            )),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Annulla'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final nome = nomeController.text.trim();
              widget.onAdd(nome, selectedBudget);

              Navigator.pop(context);
            }
          },
          child: const Text('Aggiungi'),
        ),
      ],
    );
  }
}

// Funzione helper per mostrare il dialog
Future<void> showAddLegaDialog(
    BuildContext context, {
      required Function(String nome, int budget) onAdd,
    }) async {
  return showDialog(
    context: context,
    builder: (context) => AddLegaDialog(onAdd: onAdd),
  );
}
