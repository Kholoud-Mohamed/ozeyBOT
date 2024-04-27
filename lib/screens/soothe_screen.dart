import 'package:flutter/material.dart';
import 'package:mapfeature_project/helper/constants.dart';
import 'package:mapfeature_project/widgets/customButton.dart';

class sotheeScreen extends StatelessWidget {
  const sotheeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: backgroundsoothe,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("HI , I'm Ozey",
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: AlegreyaFont,
                    fontWeight: FontWeight.w900,
                    color: labelColor,
                  )),
              Image.asset(
                'images/photo_2024-01-17_04-14-54-removebg-preview.png', // Replace 'your_gif_file.gif' with the path to your GIF file
                height: 300,
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              CustomButton(
                text: 'Get Started',
                onTap: () {
                  Navigator.pushNamed(context, 'login');
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Everyday Therapy in your hands',
                style: TextStyle(fontFamily: 'Langar'),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(
                        fontFamily: 'Langar',
                        color: Color.fromARGB(255, 136, 136, 136)),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'signup');
                    },
                    child: const Text(
                      ' Sign up',
                      style: TextStyle(
                        fontFamily: 'Langar',
                        color: Color(0xff1F5D6B),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
