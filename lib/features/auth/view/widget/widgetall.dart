// inputan
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_pallete.dart';
import '../pages/detailssubservicepage.dart';
import '../pages/registerpage.dart';

class Customfield extends StatelessWidget {
  final String LabelText;
  final TextEditingController controller;
  const Customfield({
    super.key,
    required this.LabelText,
    required this.controller,
    required String? Function(String? value) validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: LabelText,
        labelStyle: const TextStyle(fontFamily: 'Lexendregular', fontSize: 12),
      ),
    );
  }
}

// button login
class GradientButton extends StatelessWidget {
  const GradientButton({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.9,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Pallete.gradient5, Pallete.gradient6],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Container(
        height: 50,
        child: Center(
          child: Text(
            "Masuk",
            style: TextStyle(
              fontFamily: 'Lexendbold',
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

//text button
class buttonText extends StatelessWidget {
  const buttonText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "belum punya akun? ",
          style: TextStyle(fontFamily: 'Lexendregular'),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return Registerpage();
                },
              ),
            );
          },
          child: const Text(
            "Daftar",
            style: TextStyle(
              color: Pallete.gradient5,
              fontFamily: 'Lexendbold',
            ),
          ),
        ),
      ],
    );
  }
}

//text button 2
class buttonText2 extends StatelessWidget {
  final Color;
  final Text;
  const buttonText2({super.key, required this.Color, required this.Text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color,
      ),
      width: 80,
      height: 40,
      child: Center(child: Text),
    );
  }
}

// icon button
class buttonIcon extends StatelessWidget {
  final Icon;
  const buttonIcon({super.key, required this.Icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Pallete.buttonColor,
        borderRadius: BorderRadius.circular(50),
      ),
      width: MediaQuery.of(context).size.width * 0.20,
      height: MediaQuery.of(context).size.width * 0.20,
      child: Icon,
    );
  }
}

//dropdown
class Dropdownmenu extends StatefulWidget {
  const Dropdownmenu({super.key});

  @override
  State<Dropdownmenu> createState() => _DropdownbtnState();
}

class _DropdownbtnState extends State<Dropdownmenu> {
  String? selected;

  List<String> kapasitas = ['10mb', '20mb', '30mb'];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: SizedBox(
        width: 400,
        child: DropdownButton2(
          hint: const Text(
            "Kapasitas",
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Lexendbold',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          items: kapasitas
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e,
                    style: const TextStyle(
                      fontFamily: 'Lexendbold',
                      fontSize: 12,
                    ),
                  ),
                ),
              )
              .toList(),
          value: selected,
          onChanged: (value) {
            setState(() {
              selected = value;
            });
          },
          buttonStyleData: ButtonStyleData(
            decoration: BoxDecoration(
              color: Pallete.gradient2,
              borderRadius: BorderRadius.circular(10),
            ),
            overlayColor: const WidgetStatePropertyAll(Colors.orange),
          ),
        ),
      ),
    );
  }
}

//profile picture
class profilePic extends StatelessWidget {
  final Image;
  const profilePic({super.key, required this.Image});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Pallete.buttonColor,
        borderRadius: BorderRadius.circular(100),
      ),
      width: MediaQuery.of(context).size.width * 0.40,
      height: MediaQuery.of(context).size.width * 0.40,
      child: Image,
    );
  }
}

//card view
class viewCard extends StatelessWidget {
  final Color color;
  final String title;
  final String desc;
  //final String page;

  const viewCard({
    super.key,
    required this.title,
    required this.desc,
    required this.color,
    //required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          color: color,
          child: Padding(
            padding: EdgeInsets.all(
              constraints.maxWidth * 0.05,
            ), // Padding relatif
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(fontFamily: 'Lexendbold')),
                      const SizedBox(height: 4),
                      Text(
                        desc,
                        softWrap: true,
                        style: TextStyle(fontFamily: 'Lexendregular'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

//card chart
class cardChart extends StatelessWidget {
  final Color color;
  final String mbps;
  final String subservice;
  const cardChart({
    super.key,
    required this.mbps,
    required this.color,
    required this.subservice,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          color: color,
          child: Padding(
            padding: EdgeInsets.all(
              constraints.maxWidth * 0.05,
            ), // Padding relatif
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subservice,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        mbps,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => DetailService()),
                          );
                        },
                        child: buttonText2(
                          Color: Color.fromARGB(255, 255, 1, 1),
                          Text: Text("Detail"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
