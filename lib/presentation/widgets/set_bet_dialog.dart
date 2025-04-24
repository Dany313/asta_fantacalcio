import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SetBetDialog extends StatefulWidget {
  final int initialValue;
  final Function(int bet) onConfirm;

  const SetBetDialog({
    super.key,
    required this.initialValue,
    required this.onConfirm,
  });

  @override
  State<SetBetDialog> createState() => _SetBetDialogState();
}

class _SetBetDialogState extends State<SetBetDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController betController;

  @override
  void initState() {
    super.initState();
    betController = TextEditingController(text: widget.initialValue.toString());
  }

  @override
  void dispose() {
    betController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'INSERISCI OFFERTA',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: betController,
              decoration: const InputDecoration(
                labelText: 'Offerta',
                hintText: 'Inserisci il valore dell\'offerta',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Inserisci un valore';
                }
                final number = int.tryParse(value);
                if (number == null) {
                  return 'Valore non valido';
                }
                if (number < 0) {
                  return 'L\'offerta non può essere negativa';
                }
                return null;
              },
              autofocus: true,
            ),
            const SizedBox(height: 16),
            // Pulsanti di incremento rapido
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _quickAddButton(1),
                _quickAddButton(5),
                _quickAddButton(10),
              ],
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
              final bet = int.parse(betController.text);
              widget.onConfirm(bet);
              Navigator.pop(context);
            }
          },
          child: const Text('Conferma'),
        ),
      ],
    );
  }

  Widget _quickAddButton(int value) {
    return OutlinedButton(
      onPressed: () {
        final currentValue = int.tryParse(betController.text) ?? 0;
        setState(() {
          betController.text = (currentValue + value).toString();
        });
      },
      child: Text('+$value'),
    );
  }
}

// Funzione helper per mostrare il dialog
Future<void> showSetBetDialog(
    BuildContext context, {
      required int initialValue,
      required Function(int bet) onConfirm,
    }) async {
  return showDialog(
    context: context,
    builder: (context) => SetBetDialog(
      initialValue: initialValue,
      onConfirm: onConfirm,
    ),
  );
}