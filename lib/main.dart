import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DigitalSignature(),
    );
  }
}

class DigitalSignature extends StatefulWidget {
  const DigitalSignature({super.key});

  @override
  State<DigitalSignature> createState() => _DigitalSignatureState();
}

class _DigitalSignatureState extends State<DigitalSignature> {
  Uint8List? exportImage;
  SignatureController controllerSignature = SignatureController(
    //propriedades do signature
    penStrokeWidth: 3,
    penColor: Colors.black45,
    exportBackgroundColor: Colors.amber[100]!
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
        title: Text("Bueno - Assinatura Digital"),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Signature(
              controller: controllerSignature,
              height: 300,
              width: MediaQuery.of(context).size.width / 1.10,
              backgroundColor: Colors.blue[200]!,
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.all(1.5),
                  child: ElevatedButton(
                    child: Text("Limpar Assinatura"),
                    onPressed: () async {
                      controllerSignature.clear();
                      setState(() {});
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(1.5),
                  child: ElevatedButton(
                    child: Text("Salvar Assinatura"),
                    onPressed: () async {
                      exportImage = await controllerSignature.toPngBytes();
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            if (exportImage != null)
              Image.memory(
                exportImage!,
                width: MediaQuery.of(context).size.width / 1.10,
                height: 250,
              ),
            if (exportImage != null)
              ElevatedButton(onPressed: () {
                setState(() {
                  exportImage = null;
                });
              }, child: Text("Excluir")),
          ],
        ),
      ),
    );
  }
}
