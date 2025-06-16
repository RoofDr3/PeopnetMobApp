import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peopnet/core/providers/static_provider.dart';
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
      // Update user yang sedang login
      final users = ref.read(userListProvider.notifier);
      final updated = user.copyWith(
        username: namecontroller.text,
        email: emailcontroller.text,
        alamat: alamatcontroller.text,
        password: passwordcontroller.text,
      );
      // Update list user
      users.state = [
        for (final u in users.state)
          if (u.username == user.username) updated else u,
      ];
      // Update current user
      ref.read(currentUserProvider.notifier).state = updated;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Profile berhasil diubah!')));
    }
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
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        backgroundColor: Pallete.gradient1,
                        radius: 46,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 42,
                          child: ClipOval(
                            child: Image.asset(
                              "assets/img/logopeop.png",
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            // Aksi ganti foto (jika ingin tambahkan fitur ini)
                          },
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Pallete.buttonColor,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    "Edit Profil",
                    style: TextStyle(
                      fontFamily: 'Lexendbold',
                      fontSize: 20,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Customfield(
                    LabelText: "nama",
                    controller: namecontroller,
                    validator: _defaultValidator,
                  ),
                  const SizedBox(height: 14),
                  Customfield(
                    LabelText: "email",
                    controller: emailcontroller,
                    validator: _defaultValidator,
                  ),
                  const SizedBox(height: 14),
                  Customfield(
                    LabelText: "alamat",
                    controller: alamatcontroller,
                    validator: _defaultValidator,
                  ),
                  const SizedBox(height: 14),
                  Customfield(
                    LabelText: "password",
                    controller: passwordcontroller,
                    validator: _defaultValidator,
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
