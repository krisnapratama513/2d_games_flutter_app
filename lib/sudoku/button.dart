import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final void Function(int) inputNumber;

  const ButtonWidget({super.key, required this.inputNumber});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 360),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(5, (index) {
              int number = index + 1;
              return ElevatedButton(
                onPressed: () => inputNumber(number),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(20, 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  number.toString(),
                  style: const TextStyle(fontSize: 17),
                ),
              );
            }),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(4, (index) {
              int number = index + 6;
              return ElevatedButton(
                onPressed: () => inputNumber(number),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(20, 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: Text(
                  number.toString(),
                  style: const TextStyle(fontSize: 17),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
