import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectedFrame extends StatelessWidget {
  final BuildContext parentContext;
  final Widget nextPage;
  final marginVal = 30.0;
  final textSize = 28.0;

  final String title;

  final List<String> svgs;

  const SelectedFrame(
    {
      super.key,
      required this.parentContext,
      required this.nextPage,
      required this.title,
      required this.svgs
    }
  );
  @override
  Widget build(BuildContext parentContext) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          parentContext,
          MaterialPageRoute(
              builder: (context) =>  nextPage),
        );
      },
      child: Container(
          decoration: BoxDecoration(
            border:
                Border.all(color: Colors.black, width: 3),
            borderRadius: BorderRadius.circular(35),
          ),
          height: 160,
          width: 180,
          margin: EdgeInsets.only(
            left: marginVal,
            right: marginVal,
            bottom: marginVal,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: textSize,
                  fontFamily: 'Playpen-Sans',
                ),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
                crossAxisAlignment:
                    CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    // 'assets/imgs/apartment.svg',
                    svgs[0]
                  ),
                  SvgPicture.asset(
                    // 'assets/imgs/electric_bolt.svg',
                    svgs[1]
                  ),
                  SvgPicture.asset(
                    // 'assets/imgs/domino_mask.svg',
                    svgs[2]
                  )
                ],
              )
            ],
          )
        ),
    );
  }
}
