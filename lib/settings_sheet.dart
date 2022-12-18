import 'package:flutter/material.dart';
import 'package:qr_code_generator/models/epc_character_set.dart';
import 'package:qr_code_generator/models/epc_data.dart';
import 'package:qr_code_generator/models/epc_version.dart';

class SettingsSheet extends StatefulWidget {
  const SettingsSheet({
    super.key,
    required this.data,
  });

  final EpcData data;

  @override
  State<SettingsSheet> createState() => _SettingsSheetState();
}

class _SettingsSheetState extends State<SettingsSheet> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController iban = TextEditingController();
  TextEditingController beneficiaryName = TextEditingController();
  TextEditingController bic = TextEditingController();
  TextEditingController purpose = TextEditingController();
  ValueNotifier<EpcCharacterSet> characterSet =
      ValueNotifier(EpcCharacterSet.utf8);
  TextEditingController remittanceInfo = TextEditingController();
  ValueNotifier<bool> useStructuredRemittanceInfo = ValueNotifier(false);
  TextEditingController originatorInfo = TextEditingController();
  ValueNotifier<EpcVersion> version = ValueNotifier(EpcVersion.version2);

  List<ChangeNotifier> get listenables => [
        iban,
        beneficiaryName,
        bic,
        purpose,
        characterSet,
        remittanceInfo,
        useStructuredRemittanceInfo,
        originatorInfo,
        version,
      ];

  @override
  void initState() {
    updateForm();
    for (final listenable in listenables) {
      listenable.addListener(updateValue);
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SettingsSheet oldWidget) {
    if (oldWidget.data != widget.data) {
      updateForm();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    for (final listenable in listenables) {
      listenable.removeListener(updateValue);
      listenable.dispose();
    }
    super.dispose();
  }

  void updateForm() {
    iban.text = widget.data.iban;
    beneficiaryName.text = widget.data.beneficiaryName;
    bic.text = widget.data.bic ?? '';
    purpose.text = widget.data.purpose ?? '';
    characterSet.value = widget.data.characterSet;
    remittanceInfo.text = widget.data.remittanceInfo ?? '';
    useStructuredRemittanceInfo.value = widget.data.useStructuredRemittanceInfo;
    originatorInfo.text = widget.data.originatorInfo ?? '';
    version.value = widget.data.version;
  }

  void updateValue() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_formKey.currentState?.validate() != true) {
        return;
      }
      widget.data.iban = iban.text;
      widget.data.beneficiaryName = beneficiaryName.text;
      widget.data.bic = bic.text;
      widget.data.purpose = purpose.text;
      widget.data.characterSet = characterSet.value;
      widget.data.remittanceInfo = remittanceInfo.text;
      widget.data.useStructuredRemittanceInfo =
          useStructuredRemittanceInfo.value;
      widget.data.originatorInfo = originatorInfo.text;
      widget.data.version = version.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: iban,
                validator: EpcData.validateIban,
                decoration: const InputDecoration(
                  label: Text('IBAN'),
                  helperText:
                      'The IBAN number of the bank account to the send money to.',
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: bic,
                validator: (value) => EpcData.validateBic(value, version.value),
                decoration: const InputDecoration(
                  label: Text('BIC'),
                  helperText:
                      'The BIC number of the bank to send the money to.',
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: beneficiaryName,
                validator: EpcData.validateBeneficiaryName,
                decoration: const InputDecoration(
                  label: Text('Beneficiary name'),
                  helperText: 'The name of the receiver of the money.',
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField(
                value: version.value,
                validator: (value) => EpcData.validateVersion(value, bic.text),
                decoration: const InputDecoration(
                  label: Text('Version'),
                  helperText: 'The version of the EPC QR code.',
                ),
                items: EpcVersion.values.map((e) {
                  return DropdownMenuItem<EpcVersion>(
                    value: e,
                    child: Text(e.name),
                  );
                }).toList(),
                onChanged: (v) => version.value = v ?? EpcVersion.version2,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: purpose,
                validator: EpcData.validatePurpose,
                decoration: const InputDecoration(
                  label: Text('Purpose'),
                  helperText: 'Purpose of the SEPA credit transfer.',
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text('Use structured remittance info'),
                  ValueListenableBuilder<bool>(
                    valueListenable: useStructuredRemittanceInfo,
                    builder: (context, value, _) => Checkbox(
                      value: value,
                      onChanged: (v) =>
                          useStructuredRemittanceInfo.value = v ?? false,
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: remittanceInfo,
                validator: (value) => EpcData.validateRemittanceInfo(
                  value,
                  isStructured: useStructuredRemittanceInfo.value,
                ),
                decoration: const InputDecoration(
                  label: Text('Remittance information'),
                  helperText: 'Information about the payment.',
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: originatorInfo,
                validator: EpcData.validateOriginatorInfo,
                decoration: const InputDecoration(
                  label: Text('Originator information'),
                  helperText: 'Information about the originator.',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
