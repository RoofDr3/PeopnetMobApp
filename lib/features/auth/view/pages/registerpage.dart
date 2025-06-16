import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peopnet/core/data/static_data.dart';
import 'package:peopnet/core/providers/static_provider.dart';
import '../../../../core/theme/app_pallete.dart';
import '../widget/widgetall.dart';

class Registerpage extends ConsumerStatefulWidget {
  const Registerpage({super.key});
  @override
  ConsumerState<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends ConsumerState<Registerpage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final alamatController = TextEditingController();
  final passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  String? error;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    alamatController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? _defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field tidak boleh kosong';
    }
    return null;
  }

  void _register() {
    final users = ref.read(userListProvider.notifier);
    // Cek username sudah ada
    if (users.state.any((u) => u.username == nameController.text)) {
      setState(() {
        error = "Username sudah terdaftar";
      });
      return;
    }
    users.state = [
      ...users.state,
      DummyUser(
        username: nameController.text,
        password: passwordController.text,
        email: emailController.text,
        alamat: alamatController.text,
      ),
    ];
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: TextStyle(color: Colors.white)),
        backgroundColor: Pallete.buttonColor,
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Center(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Text(
                  "Registrasi",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                if (error != null)
                  Text(error!, style: TextStyle(color: Colors.red)),
                SizedBox(height: 30),
                Customfield(
                  LabelText: "nama",
                  controller: nameController,
                  validator: _defaultValidator,
                ),
                Customfield(
                  LabelText: "email",
                  controller: emailController,
                  validator: _defaultValidator,
                ),
                Customfield(
                  LabelText: "alamat",
                  controller: alamatController,
                  validator: _defaultValidator,
                ),
                Customfield(
                  LabelText: "password",
                  controller: passwordController,
                  validator: _defaultValidator,
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    if (formkey.currentState!.validate()) {
                      _register();
                    }
                  },
                  child: buttonText2(
                    Color: Pallete.buttonColor,
                    Text: Text("Daftar", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
