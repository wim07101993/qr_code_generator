import 'package:flutter/material.dart';
import 'package:qr_code_generator/qr_data_controller.dart';
import 'package:qr_code_generator/shared/widgets/styled_qr_code.dart';

class QrCodeScreen extends StatelessWidget {
  const QrCodeScreen({
    super.key,
    required this.inputBuilder,
    required this.qrData,
  });

  final WidgetBuilder inputBuilder;
  final QrDataController qrData;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final qrCode = ListenableBuilder(
          listenable: qrData,
          builder: (context, data) => StyledQrCode(data: qrData.value),
        );

        const double inputWidth = 250;
        final input = Padding(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: inputWidth,
              maxWidth: inputWidth,
            ),
            child: inputBuilder(context),
          ),
        );

        if ((constraints.maxWidth - inputWidth) > constraints.maxHeight) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: input),
              qrCode,
            ],
          );
        } else {
          return SingleChildScrollView(
            child: Column(children: [qrCode, input]),
          );
        }
      },
    );
  }
}
