import 'package:flutter/material.dart';
import 'package:qr_code_generator/epc_qr_code.dart';
import 'package:qr_code_generator/models/epc_data.dart';
import 'package:qr_code_generator/shared_preferrences_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final data = EpcData(
    amount: '3.14',
    iban: 'BE10779597575204',
    beneficiaryName: "Wim Van Laer",
  );
  final sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.loadEpcDataTo(data);

  data.addListener(() => sharedPreferences.saveEpcData(data));

  runApp(
    MaterialApp(
      title: 'QR-code generator',
      home: EpcQrCode(data: data),
      debugShowCheckedModeBanner: false,
    ),
  );
}
