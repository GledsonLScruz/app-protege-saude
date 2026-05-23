import 'package:flutter/material.dart';

import '../../../shared/models/complaint_models.dart';

class AddressStep extends StatefulWidget {
  const AddressStep({
    super.key,
    required this.address,
    required this.isValidatingCep,
    required this.cepMessage,
    required this.cepError,
    required this.showErrors,
    required this.onAddressChanged,
    required this.onValidateCep,
  });

  final ComplaintAddress address;
  final bool isValidatingCep;
  final String? cepMessage;
  final String? cepError;
  final bool showErrors;
  final void Function({String? cep, String? rua, String? numero})
  onAddressChanged;
  final VoidCallback onValidateCep;

  @override
  State<AddressStep> createState() => _AddressStepState();
}

class _AddressStepState extends State<AddressStep> {
  late final TextEditingController _cepController;
  late final TextEditingController _streetController;
  late final TextEditingController _numberController;

  @override
  void initState() {
    super.initState();
    _cepController = TextEditingController(text: widget.address.cep);
    _streetController = TextEditingController(text: widget.address.rua);
    _numberController = TextEditingController(text: widget.address.numero);
  }

  @override
  void didUpdateWidget(covariant AddressStep oldWidget) {
    super.didUpdateWidget(oldWidget);
    _sync(_cepController, widget.address.cep);
    _sync(_streetController, widget.address.rua);
    _sync(_numberController, widget.address.numero);
  }

  @override
  void dispose() {
    _cepController.dispose();
    _streetController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
      children: [
        Text(
          'Endereço da vítima',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        const Text(
          'Se a criança/adolescente residir fora de Campina Grande, informe o CEP do local onde a violência ocorreu em Campina Grande.',
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _cepController,
          keyboardType: TextInputType.number,
          maxLength: 9,
          decoration: InputDecoration(
            labelText: 'CEP',
            counterText: '',
            errorText: widget.showErrors && widget.address.cep.length < 9
                ? 'Informe um CEP válido.'
                : widget.cepError,
            suffixIcon: widget.isValidatingCep
                ? const Padding(
                    padding: EdgeInsets.all(12),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : IconButton(
                    icon: const Icon(Icons.search_rounded),
                    onPressed: widget.onValidateCep,
                  ),
          ),
          onChanged: (value) {
            widget.onAddressChanged(cep: value);
            if (value.replaceAll(RegExp(r'\D'), '').length == 8) {
              widget.onValidateCep();
            }
          },
        ),
        if (widget.cepMessage != null) ...[
          const SizedBox(height: 6),
          Text(
            widget.cepMessage!,
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ],
        const SizedBox(height: 14),
        TextField(
          controller: _streetController,
          decoration: InputDecoration(
            labelText: 'Rua',
            errorText: widget.showErrors && widget.address.rua.trim().length < 3
                ? 'Informe a rua.'
                : null,
          ),
          onChanged: (value) => widget.onAddressChanged(rua: value),
        ),
        const SizedBox(height: 14),
        TextField(
          controller: _numberController,
          decoration: InputDecoration(
            labelText: 'Número',
            errorText: widget.showErrors && widget.address.numero.trim().isEmpty
                ? 'Informe o número.'
                : null,
          ),
          onChanged: (value) => widget.onAddressChanged(numero: value),
        ),
        const SizedBox(height: 14),
        _ReadonlyField(label: 'Estado', value: widget.address.estado),
        const SizedBox(height: 14),
        _ReadonlyField(label: 'Cidade', value: widget.address.cidade),
        const SizedBox(height: 14),
        _ReadonlyField(label: 'Bairro', value: widget.address.bairro),
      ],
    );
  }

  void _sync(TextEditingController controller, String value) {
    if (controller.text == value) {
      return;
    }
    controller.value = TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: value.length),
    );
  }
}

class _ReadonlyField extends StatelessWidget {
  const _ReadonlyField({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(text: value),
      enabled: false,
      decoration: InputDecoration(labelText: label),
    );
  }
}
