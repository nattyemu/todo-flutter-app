import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  const InputField({super.key});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  TextEditingController myControler = TextEditingController();

  String greattingMessage = '';
  void greatting() {
    String username = myControler.text;
    setState(() {
      greattingMessage = "Hello, $username";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(23.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(greattingMessage),
              TextField(
                controller: myControler,
                decoration: const InputDecoration(
                    hintText: "first name", border: OutlineInputBorder()),
              ),
              ElevatedButton(
                onPressed: greatting,
                child: const Text("tap to send"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
