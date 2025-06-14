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
      appBar: AppBar(
        title: Text(
          "account",
          style: TextStyle(fontFamily: 'Lexendregular', color: Colors.white),
        ),
        backgroundColor: Pallete.buttonColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(40),
        child: Center(
          child: Column(
            children: [
              profilePic(Image: Image.asset("assets/img/logopeop.png")),
              SizedBox(height: 20),
              Customfield(
                LabelText: "nama",
                controller: namecontroller,
                obscureText: false,
                validator: _defaultValidator,
              ),
              Customfield(
                LabelText: "email",
                controller: emailcontroller,
                obscureText: false,
                validator: _defaultValidator,
              ),
              Customfield(
                LabelText: "alamat",
                controller: alamatcontroller,
                obscureText: false,
                validator: _defaultValidator,
              ),
              Customfield(
                LabelText: "password",
                controller: passwordcontroller,
                obscureText: false,
                validator: _defaultValidator,
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: _ubahProfile,
                child: buttonText2(
                  Color: Pallete.buttonColor,
                  Text: Text(
                    "Ubah",
                    style: TextStyle(
                      fontFamily: 'Lexendbold',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
