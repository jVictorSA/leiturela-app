import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReturnButton extends StatelessWidget {
  final BuildContext parentContext;
  const ReturnButton(
    {super.key, required this.parentContext}
  );
  @override
  Widget build(BuildContext parentContext) {
    return 
    Container(
      margin: const EdgeInsets.only(left: 40, top: 10), 
      child: Center(
        child: IconButton.outlined(
          iconSize: 40,
          icon: SvgPicture.asset(
                  'assets/imgs/return.svg',                
                ),
          onPressed: () {
            Navigator.pop(parentContext);
          },              
          style:  ButtonStyle(            
            backgroundColor: MaterialStateProperty.all<Color>(const Color(0xffEAEAEA)),
            fixedSize:  MaterialStateProperty.all<Size>(const Size(80, 10)),                
          ),
        ),
      )
    );
  }
}