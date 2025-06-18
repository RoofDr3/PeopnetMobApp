import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peopnet/core/data/user_data.dart';
import 'package:peopnet/core/providers/user_provider.dart';
import 'package:peopnet/core/theme/app_pallete.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});
  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final alamatController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    alamatController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      final userBaru = AppUser(
        username: usernameController.text,
        email: emailController.text,
        alamat: alamatController.text,
        password: passwordController.text,
      );
      ref.read(userListProvider.notifier).addUser(userBaru);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Register berhasil! Silakan login.')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              elevation: 10,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 36,
                  horizontal: 26,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Tidak ada icon/avatar di atas judul!
                      Text(
                        'Daftar Akun Baru',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Pallete.buttonColor,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 22),
                      TextFormField(
                        controller: usernameController,
                        decoration: const InputDecoration(
                          labelText: "Username",
                          prefixIcon: Icon(
                            Icons.person,
                            color: Pallete.buttonColor,
                          ),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Pallete.buttonColor,
                              width: 2,
                            ),
                          ),
                        ),
                        validator: (v) => (v == null || v.isEmpty)
                            ? "Username wajib diisi"
                            : null,
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          prefixIcon: Icon(
                            Icons.email,
                            color: Pallete.buttonColor,
                          ),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Pallete.buttonColor,
                              width: 2,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return "Email wajib diisi";
                          }
                          final emailRegex = RegExp(
                            r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
                          );
                          if (!emailRegex.hasMatch(v)) {
                            return "Format email tidak valid";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: alamatController,
                        decoration: const InputDecoration(
                          labelText: "Alamat",
                          prefixIcon: Icon(
                            Icons.home,
                            color: Pallete.buttonColor,
                          ),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Pallete.buttonColor,
                              width: 2,
                            ),
                          ),
                        ),
                        validator: (v) => (v == null || v.isEmpty)
                            ? "Alamat wajib diisi"
                            : null,
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: passwordController,
                        obscureText: !isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Pallete.buttonColor,
                          ),
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Pallete.buttonColor,
                              width: 2,
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Pallete.buttonColor,
                            ),
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        validator: (v) => (v == null || v.length < 6)
                            ? "Password minimal 6 karakter"
                            : null,
                      ),
                      const SizedBox(height: 28),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            backgroundColor: Pallete.buttonColor,
                            elevation: 2,
                          ),
                          onPressed: _register,
                          child: const Text(
                            "DAFTAR",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              letterSpacing: 1,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          "Sudah punya akun? Login",
                          style: TextStyle(
                            color: Pallete.buttonColor,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
