import 'package:flutter/material.dart';
import 'package:saver/Services/shared_prefrences_service.dart';

class InfoContainer extends StatelessWidget {
  const InfoContainer({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(230, 230, 230, 1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black, width: 1.5),
      ),
      child: Text("$text ${SharedPrefrencesService.currency}"),
    );
  }
}
