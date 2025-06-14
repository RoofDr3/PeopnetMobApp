import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peopnet/core/providers/static_provider.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serviceList = ref.watch(serviceListProvider);

    void goToHome() {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    }

    return WillPopScope(
      onWillPop: () async {
        goToHome();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Keranjang Layanan'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: goToHome,
          ),
        ),
        body: serviceList.isEmpty
            ? const Center(child: Text('Keranjang kosong'))
            : ListView.builder(
                itemCount: serviceList.length,
                itemBuilder: (context, index) {
                  final service = serviceList[index];
                  return ListTile(
                    title: Text(service.nama),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/detailservice',
                        arguments: service,
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}
