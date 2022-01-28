import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    required this.flag,
    required this.country,
    required this.active,
    required this.recovered,
    this.onLongPressed,
    Key? key,
  }) : super(key: key);

  final String flag;
  final String country;
  final int active;
  final int recovered;
  final Function()? onLongPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        flag,
        loadingBuilder: (
          BuildContext context,
          Widget child,
          ImageChunkEvent? loadingProgress,
        ) {
          if (loadingProgress == null) return child;
          return const CircularProgressIndicator();
        },
        height: 50,
        width: 50,
        errorBuilder:
            (BuildContext context, Object object, StackTrace? trace) =>
                const CircularProgressIndicator(
          color: Colors.red,
        ),
        fit: BoxFit.contain,
      ),
      title: Text(country),
      subtitle: Text.rich(
        TextSpan(
          children: [
            const TextSpan(text: 'active: '),
            TextSpan(
              text: active.toString(),
              style: const TextStyle(color: Colors.red),
            ),
            const TextSpan(text: ' recovered: '),
            TextSpan(
              text: recovered.toString(),
              style: const TextStyle(color: Colors.green),
            )
          ],
        ),
      ),
      onLongPress: onLongPressed,
    );
  }
}
