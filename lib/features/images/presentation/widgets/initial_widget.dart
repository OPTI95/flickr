import 'package:flutter/material.dart';

class InitialWidget extends StatelessWidget {
  final String text;
  const InitialWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Spacer(),
          Image.asset("assets/images/flickr 1.png"),
          const SizedBox(
            height: 20,
          ),
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const Spacer()
        ],
      ),
    );
  }
}