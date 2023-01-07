import 'package:flutter/material.dart';
import 'package:qr_code_generator/features/epc/notifiers/epc_data.dart';
import 'package:qr_code_generator/features/epc/notifiers/epc_version.dart';
import 'package:qr_code_generator/main.dart';
import 'package:qr_code_generator/shared/l10n/localization.dart';

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
    final s = AppLocalizations.of(context)!;
    return Column(
      children: [
        TextFormField(
          controller: notifier.iban,
          validator: EpcData.validateIban,
          decoration: InputDecoration(
            label: const Text('IBAN'),
            helperText: s.ibanSettingHelperText,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: notifier.beneficiaryName,
          validator: EpcData.validateBeneficiaryName,
          decoration: InputDecoration(
            label: Text(s.beneficiaryName),
            helperText: s.beneficiaryNameSettingHelperText,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Text(s.useStructuredRemittanceInfoCheckboxLabel),
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
          decoration: InputDecoration(
            label: Text(s.remittanceInfo),
            helperText: s.remittanceInfoSettingHelperText,
          ),
        ),
        TextFormField(
          controller: notifier.bic,
          validator: (value) =>
              EpcData.validateBic(value, notifier.version.value),
          decoration: InputDecoration(
            label: const Text('BIC'),
            helperText: s.bicSettingHelperText,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: notifier.purpose,
          validator: EpcData.validatePurpose,
          decoration: InputDecoration(
            label: Text(s.purpose),
            helperText: s.purposeSettingHelperText,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: notifier.originatorInfo,
          validator: EpcData.validateOriginatorInfo,
          decoration: InputDecoration(
            label: Text(s.originatorInfo),
            helperText: s.originatorInfoSettingHelperText,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField(
          value: notifier.version.value,
          validator: (value) =>
              EpcData.validateVersion(value, notifier.bic.text),
          decoration: InputDecoration(
            label: Text(s.version),
            helperText: s.versionSettingHelperText,
          ),
          items: EpcVersion.values.map((e) {
            return DropdownMenuItem<EpcVersion>(
              value: e,
              child: Text(e.translate(s)),
            );
          }).toList(),
          onChanged: (v) => notifier.version.value = v ?? EpcVersion.version2,
        ),
      ],
    );
  }
}
