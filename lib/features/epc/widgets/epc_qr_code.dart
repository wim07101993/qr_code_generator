import 'package:flutter/material.dart';
import 'package:qr_code_generator/features/epc/notifiers/epc_data.dart';
import 'package:qr_code_generator/features/epc/widgets/settings_sheet.dart';
import 'package:qr_flutter/qr_flutter.dart';

class EpcQrCode extends StatefulWidget {
  const EpcQrCode({
    super.key,
    required this.data,
  });

  final EpcData data;

  @override
  State<EpcQrCode> createState() => _EpcQrCodeState();
}

class _EpcQrCodeState extends State<EpcQrCode> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController amount = TextEditingController();

  String? get amountErrorMessage => EpcData.validateAmount(amount.text);

  @override
  void initState() {
    amount.text = widget.data.amount;
    amount.addListener(onAmountChanged);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant EpcQrCode oldWidget) {
    if (amount.text != widget.data.amount) {
      amount.text = widget.data.amount;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    amount.removeListener(onAmountChanged);
    amount.dispose();
    super.dispose();
  }

  void onAmountChanged() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (formKey.currentState?.validate() != true) {
        return;
      }
      widget.data.amount = amount.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<String>(
        valueListenable: widget.data,
        builder: (context, stringData, _) => Column(
          children: [
            SafeArea(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: amount,
                          validator: EpcData.validateAmount,
                          keyboardType: TextInputType.number,
                          decoration:
                              const InputDecoration(label: Text('Amount')),
                        ),
                      ),
                      IconButton(
                        onPressed: () => showModalBottomSheet(
                          context: context,
                          builder: (context) =>
                              SettingsSheet(data: widget.data),
                        ),
                        icon: const Icon(Icons.settings),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(child: QrImage(data: stringData)),
          ],
        ),
      ),
    );
  }
}
