import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peopnet/core/providers/user_provider.dart';
import '../../../../core/theme/app_pallete.dart';
import '../widget/widgetall.dart';

class Accountpage extends ConsumerStatefulWidget {
  const Accountpage({super.key});

  @override
  ConsumerState<Accountpage> createState() => _AccountpageState();
}

class _AccountpageState extends ConsumerState<Accountpage> {
  final namecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final alamatcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = ref.read(currentUserProvider);
      if (user != null) {
        namecontroller.text = user.username;
        emailcontroller.text = user.email;
        alamatcontroller.text = user.alamat;
        passwordcontroller.text = user.password;
      }
    });
  }

  @override
  void dispose() {
    namecontroller.dispose();
    emailcontroller.dispose();
    alamatcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  String? _defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field tidak boleh kosong';
    }
    return null;
  }

  void _ubahProfile() {
    final user = ref.read(currentUserProvider);
    if (user != null) {
      final users = ref.read(userListProvider.notifier);
      final updated = user.copyWith(
        username: namecontroller.text,
        email: emailcontroller.text,
        alamat: alamatcontroller.text,
        password: passwordcontroller.text,
      );
      users.updateUser(updated);
      ref.read(currentUserProvider.notifier).state = updated;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Profile berhasil diubah!')));
    }
  }

  Widget _inputRow(
    String label,
    TextEditingController controller, {
    bool obscure = false,
    String? Function(String?)? validator,
  }) {
    // GANTI di bawah dengan Customfield atau widget yang sudah kamu pakai sebelumnya!
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 85,
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'Lexendbold',
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Customfield(
              LabelText: label,
              controller: controller,
              validator: _defaultValidator,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(currentUserProvider);
    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Akun Saya",
          style: TextStyle(fontFamily: 'Lexendbold', color: Colors.white),
        ),
        backgroundColor: Pallete.buttonColor,
        elevation: 2,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Center(
          child: Card(
            elevation: 7,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ... avatar dan lain-lain tetap sesuai design kamu ...
                  _inputRow(
                    "Nama",
                    namecontroller,
                    validator: _defaultValidator,
                  ),
                  _inputRow(
                    "Email",
                    emailcontroller,
                    validator: _defaultValidator,
                  ),
                  _inputRow(
                    "Alamat",
                    alamatcontroller,
                    validator: _defaultValidator,
                  ),
                  _inputRow(
                    "Password",
                    passwordcontroller,
                    validator: _defaultValidator,
                    obscure: true,
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      onPressed: _ubahProfile,
                      icon: const Icon(Icons.save, color: Colors.white),
                      label: const Text(
                        "Simpan Perubahan",
                        style: TextStyle(
                          fontFamily: 'Lexendbold',
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Pallete.buttonColor,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
