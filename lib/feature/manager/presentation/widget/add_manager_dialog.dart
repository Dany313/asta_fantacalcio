import 'package:flutter/material.dart';

import '../../../../core/validators/string_validator.dart';

class AddManagerDialog extends StatefulWidget {
  final Function(String nome) onAdd;

  const AddManagerDialog({
    super.key,
    required this.onAdd,
  });

  @override
  State<AddManagerDialog> createState() => _AddManagerDialogState();
}

class _AddManagerDialogState extends State<AddManagerDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nomeController = TextEditingController();

  @override
  void dispose() {
    nomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'AGGIUNGI PARTECIPANTE',
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
                hintText: 'Inserisci il nome del partecipante',
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
              widget.onAdd(nome);

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
Future<void> showAddPartecipanteDialog(
    BuildContext context, {
      required Function(String nome) onAdd,
    }) async {
  return showDialog(
    context: context,
    builder: (context) => AddManagerDialog(onAdd: onAdd),
  );
}
