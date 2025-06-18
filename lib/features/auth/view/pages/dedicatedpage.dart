import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peopnet/core/data/static_data.dart';
import 'package:peopnet/core/providers/static_provider.dart';
import 'package:peopnet/core/providers/user_provider.dart';
import 'package:peopnet/core/theme/app_pallete.dart';

class Dedicatedpage extends ConsumerStatefulWidget {
  const Dedicatedpage({super.key});

  @override
  ConsumerState<Dedicatedpage> createState() => _DedicatedpageState();
}

class _DedicatedpageState extends ConsumerState<Dedicatedpage> {
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final alamatController = TextEditingController();
  final koordinatController = TextEditingController();

  final List<String> kapasitasOptions = [
    '10 Mbps',
    '20 Mbps',
    '30 Mbps',
    '50 Mbps',
    '100 Mbps',
  ];
  String? selectedKapasitas;

  @override
  void initState() {
    super.initState();
    final randomId = (Random().nextInt(900000) + 100000).toString();
    idController.text = randomId;
  }

  @override
  void dispose() {
    idController.dispose();
    nameController.dispose();
    alamatController.dispose();
    koordinatController.dispose();
    super.dispose();
  }

  void _addService() {
    final user = ref.read(currentUserProvider);
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan login dulu!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (nameController.text.isEmpty ||
        alamatController.text.isEmpty ||
        selectedKapasitas == null ||
        koordinatController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Isi semua data dengan benar!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final service = DummyService(
      idPelanggan: idController.text,
      nama: nameController.text,
      jenisLayanan: 'Dedicated',
      kapasitas: selectedKapasitas ?? '',
      alamat: alamatController.text,
      koordinat: koordinatController.text,
      username: user.username,
    );

    ref.read(serviceListProvider.notifier).addService(service);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Layanan berhasil ditambahkan ke Cart'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pushNamed(context, '/cart');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Daftar Layanan Dedicated',
          style: TextStyle(fontFamily: 'Lexendbold', color: Colors.white),
        ),
        backgroundColor: Pallete.buttonColor,
        centerTitle: true,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 28),
          child: Card(
            elevation: 7,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: CircleAvatar(
                      backgroundColor: Pallete.buttonColor,
                      radius: 35,
                      child: const Icon(
                        Icons.public_rounded,
                        color: Colors.white,
                        size: 38,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Center(
                    child: Text(
                      "Dedicated",
                      style: TextStyle(
                        fontFamily: "Lexendbold",
                        fontSize: 20,
                        color: Pallete.buttonColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Center(
                    child: Text(
                      "Layanan internet premium dengan kecepatan simetris & SLA tinggi untuk bisnis.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Lexendregular",
                        fontSize: 13,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  const Divider(height: 26, thickness: 1.1),
                  const SizedBox(height: 4),

                  _inputLabel("ID Pelanggan"),
                  TextField(
                    controller: idController,
                    decoration: const InputDecoration(
                      hintText: 'Otomatis',
                      prefixIcon: Icon(Icons.badge),
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    readOnly: true,
                  ),
                  const SizedBox(height: 14),

                  _inputLabel("Nama"),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: 'Nama Tempat',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                  const SizedBox(height: 14),

                  _inputLabel("Alamat"),
                  TextField(
                    controller: alamatController,
                    decoration: const InputDecoration(
                      hintText: 'Alamat Lengkap',
                      prefixIcon: Icon(Icons.location_on),
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                  const SizedBox(height: 14),

                  _inputLabel("Kapasitas"),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.speed),
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    value: selectedKapasitas,
                    items: kapasitasOptions
                        .map(
                          (k) => DropdownMenuItem(
                            value: k,
                            child: Text(
                              k,
                              style: const TextStyle(
                                fontFamily: 'Lexendregular',
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (val) => setState(() => selectedKapasitas = val),
                    hint: const Text("Pilih kapasitas"),
                  ),
                  const SizedBox(height: 14),

                  _inputLabel("Koordinat"),
                  TextField(
                    controller: koordinatController,
                    decoration: const InputDecoration(
                      hintText: 'Contoh: -7.123, 110.567',
                      prefixIcon: Icon(Icons.map),
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                  const SizedBox(height: 22),

                  ElevatedButton.icon(
                    onPressed: _addService,
                    icon: const Icon(Icons.shopping_cart_checkout_rounded),
                    label: const Text('Daftar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Pallete.buttonColor,
                      foregroundColor: Colors.white,
                      elevation: 5,
                      minimumSize: const Size.fromHeight(48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: const TextStyle(
                        fontFamily: 'Lexendbold',
                        fontSize: 16,
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

  Widget _inputLabel(String label) => Padding(
    padding: const EdgeInsets.only(left: 2, bottom: 4),
    child: Text(
      label,
      style: const TextStyle(
        fontFamily: 'Lexendbold',
        fontSize: 15,
        color: Colors.black87,
      ),
    ),
  );
}
