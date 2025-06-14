import 'package:flutter/material.dart';

import '../../../../core/theme/app_pallete.dart';
import '../widget/widgetall.dart';

class Notifpage extends StatelessWidget {
  const Notifpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("notification", style: TextStyle(color: Colors.white)),
        backgroundColor: Pallete.buttonColor,
      ),
      body: Container(
        child: Column(
          children: [
            viewCard(
              title: "judul",
              desc: "detail pengingat",
              color: Colors.yellow.shade200,
            ),
          ],
        ),
      ),
    );
  }
}
