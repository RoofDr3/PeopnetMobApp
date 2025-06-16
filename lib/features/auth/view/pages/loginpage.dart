import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peopnet/core/providers/static_provider.dart';
import '../../../../core/theme/app_pallete.dart';
import '../widget/widgetall.dart';
import 'homepage.dart';

class Loginpage extends ConsumerStatefulWidget {
  const Loginpage({super.key});
  @override
  ConsumerState<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends ConsumerState<Loginpage> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? error;

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? _defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field tidak boleh kosong';
    }
    return null;
  }

  void _login() {
    final users = ref.read(userListProvider);
    try {
      final user = users.firstWhere(
        (u) =>
            u.username == nameController.text &&
            u.password == passwordController.text,
      );
      ref.read(currentUserProvider.notifier).state = user;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } catch (e) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Username atau password salah / tidak terdaftar!"),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Pallete.backgroundColor,
        padding: EdgeInsets.all(40),
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/img/logopeop.png"),
                Text(
                  "People Internet",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Lexendbold',
                    color: Pallete.gradient5,
                  ),
                ),
                if (error != null)
                  Text(error!, style: TextStyle(color: Colors.red)),
                Customfield(
                  LabelText: "username",
                  controller: nameController,
                  validator: _defaultValidator,
                ),
                Customfield(
                  LabelText: "password",
                  controller: passwordController,
                  validator: _defaultValidator,
                ),
                SizedBox(height: 30),
                InkWell(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      _login();
                    }
                  },
                  child: GradientButton(),
                ),
                SizedBox(height: 10),
                buttonText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
