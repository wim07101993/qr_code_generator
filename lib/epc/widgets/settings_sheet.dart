import 'package:flutter/material.dart';
import 'package:qr_code_generator/epc/notifiers/epc_data.dart';
import 'package:qr_code_generator/epc/notifiers/epc_version.dart';
import 'package:qr_code_generator/main.dart';

class SettingsSheet extends StatefulWidget {
  const SettingsSheet({
    super.key,
  });

  @override
  State<SettingsSheet> createState() => _SettingsSheetState();
}

class _SettingsSheetState extends State<SettingsSheet> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: ValueListenableBuilder<EpcData?>(
            valueListenable: getIt<EpcDataNotifier>(),
            builder: (context, notifier, _) => _formFields(context, getIt()),
          ),
        ),
      ),
    );
  }

  Widget _formFields(BuildContext context, EpcDataNotifier notifier) {
    return Column(
      children: [
        TextFormField(
          controller: notifier.iban,
          validator: EpcData.validateIban,
          decoration: const InputDecoration(
            label: Text('IBAN'),
            helperText:
                'The IBAN number of the bank account to the send money to.',
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: notifier.bic,
          validator: (value) =>
              EpcData.validateBic(value, notifier.version.value),
          decoration: const InputDecoration(
            label: Text('BIC'),
            helperText: 'The BIC number of the bank to send the money to.',
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: notifier.beneficiaryName,
          validator: EpcData.validateBeneficiaryName,
          decoration: const InputDecoration(
            label: Text('Beneficiary name'),
            helperText: 'The name of the receiver of the money.',
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField(
          value: notifier.version.value,
          validator: (value) =>
              EpcData.validateVersion(value, notifier.bic.text),
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
          onChanged: (v) => notifier.version.value = v ?? EpcVersion.version2,
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: notifier.purpose,
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
              valueListenable: notifier.useStructuredRemittanceInfo,
              builder: (context, value, _) => Checkbox(
                value: value,
                onChanged: (v) =>
                    notifier.useStructuredRemittanceInfo.value = v ?? false,
              ),
            ),
          ],
        ),
        TextFormField(
          controller: notifier.remittanceInfo,
          validator: (value) => EpcData.validateRemittanceInfo(
            value,
            isStructured: notifier.useStructuredRemittanceInfo.value,
          ),
          decoration: const InputDecoration(
            label: Text('Remittance information'),
            helperText: 'Information about the payment.',
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: notifier.originatorInfo,
          validator: EpcData.validateOriginatorInfo,
          decoration: const InputDecoration(
            label: Text('Originator information'),
            helperText: 'Information about the originator.',
          ),
        ),
      ],
    );
  }
}
