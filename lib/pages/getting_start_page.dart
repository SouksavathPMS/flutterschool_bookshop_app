import 'package:flutter/material.dart';
import '../widgets/main_button.dart';

class GettingStartPage extends StatelessWidget {
  const GettingStartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(top: 100),
          width: 210,
          child: Image.asset(
            "assets/images/getting_start_blooks.png",
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 40, left: 60, right: 60),
        height: 340,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              spreadRadius: 16,
              blurRadius: 8,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "ການສັ່ງຊື້ປື້ມຈະບໍ່ແມ່ນເລື່ອງຍາກອີກຕໍ່ໄປ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  height: 1.4,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "ສະຖານທີ່ທີ່ດີທີ່ສຸດໃນການເລືອກຊື້ປື້ມທີ່ທ່ານມັກ",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                height: 1.4,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 60),
            MainButton(
              title: "ຫາປື້ມທີ່ທ່ານມັກ",
              onPressed: () {
                print("object");
              },
            ),
          ],
        ),
      ),
    );
  }
}
