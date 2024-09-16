import 'package:flutter/material.dart';
import '../custom_widgets/return_button.dart';


class Settings extends StatefulWidget{
  const Settings({super.key});
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  double _efeitosSonoros = 7;
  double _musica = 7;
  bool on = true;
  bool off = false;

  @override
  Widget build(BuildContext context){
    return  Scaffold(        
      body: Container(
        decoration: const BoxDecoration( 
          image: DecorationImage(
            image: AssetImage("assets/imgs/background.png"),
            fit: BoxFit.contain,
          ),
        ),
        child: Column(
          children: [
            Row(children: 
              [ReturnButton(parentContext: context)]
            ),              
            Expanded(child:                
              Column(
                // mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      const Expanded(
                        flex: 1,
                        child: 
                          Text("Efeitos Sonoros",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontFamily: 'Playpen-Sans',
                              fontWeight: FontWeight.w500,
                              fontSize: 18
                            ),
                          ),
                      ),
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          width: 100,                            
                          child: Row(                                
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:[                                  
                              Expanded(
                                flex: 4,
                                child: SliderTheme(
                                  data:  SliderThemeData(
                                    thumbColor: Colors.white,
                                    thumbShape:  const RoundSliderThumbShape(enabledThumbRadius: 10),
                                    activeTrackColor: const Color(0xff012480),
                                    inactiveTrackColor: const Color(0xff012480),
                                    trackHeight: 8,
                                    trackShape: const RoundedRectSliderTrackShape(),
                                    showValueIndicator: ShowValueIndicator.never,
                                    tickMarkShape: SliderTickMarkShape.noTickMark
                                  ),
                                  child: Slider(
                                    value: _efeitosSonoros,
                                    max: 10,
                                    divisions: 10,
                                    // label: _musica.round().toString(),
                                    onChanged: (double value) {
                                      setState(() {
                                        _efeitosSonoros = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 50),
                                  child: Container(
                                    decoration: BoxDecoration(                                  
                                      borderRadius: BorderRadius.circular(20),                    
                                      color: const Color(0xffDADADA),
                                    ),
                                    width: 20,
                                    height: 30,
                                    child: Center(child: 
                                      Text(
                                        _efeitosSonoros.toInt().toString(),
                                        style: const TextStyle(
                                          fontFamily: 'Playpen-Sans',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600
                                        ),
                                      )
                                    )
                                  )
                                )
                              )
                            ]                            
                          )
                        )
                      )                      
                    ]
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      const Expanded(
                        flex: 1,
                        child: Text("Música",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontFamily: 'Playpen-Sans',
                            fontWeight: FontWeight.w500,
                            fontSize: 18
                          ),
                        ),
                      ),
                      Expanded(                        
                        flex: 2,
                        child: SizedBox(
                          width: 300,                          
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:[                                
                              Expanded(
                                flex: 4,
                                child: SliderTheme(
                                  data:  SliderThemeData(
                                    thumbColor: Colors.white,
                                    thumbShape:  const RoundSliderThumbShape(enabledThumbRadius: 10),
                                    activeTrackColor: const Color(0xff012480),
                                    inactiveTrackColor: const Color(0xff012480),
                                    trackHeight: 8,
                                    trackShape: const RoundedRectSliderTrackShape(),
                                    showValueIndicator: ShowValueIndicator.never,
                                    tickMarkShape: SliderTickMarkShape.noTickMark
                                  ),
                                  child: Slider(
                                    value: _musica,
                                    max: 10,
                                    divisions: 10,
                                    // label: _musica.round().toString(),
                                    onChanged: (double value) {
                                      setState(() {
                                        _musica = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 50),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),                    
                                      color: const Color(0xffDADADA),
                                    ),
                                    width: 40,
                                    height: 30,
                                    child: Center(
                                      child: Text(
                                        _musica.toInt().toString(),
                                        style: const TextStyle(
                                          fontFamily: 'Playpen-Sans',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600
                                        ),
                                      )
                                    )
                                  )
                                )
                              )
                            ]
                          )
                        )
                      )
                    ]
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      const Expanded(
                        flex: 1,
                        child: 
                        Text("Vibrações",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontFamily: 'Playpen-Sans',
                            fontWeight: FontWeight.w500,
                            fontSize: 18
                          ),
                        ),
                      ),
                      Expanded(                        
                        flex: 2,
                        child:
                        SizedBox(
                          width: 300,                            
                          child: Row(
                            children: [
                              Wrap(
                                direction: Axis.vertical,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: -15,
                                children: [
                                  Checkbox(
                                    checkColor: Colors.green,
                                    activeColor: Colors.transparent, 
                                    side: MaterialStateBorderSide.resolveWith(
                                      (states) => const BorderSide(
                                        color: Colors.black,
                                        width: 2,
                                      )
                                    ),
                                    value: off,
                                    onChanged: (value) {
                                        setState(() {
                                            off = value!;
                                            on = !on;
                                        });
                                    },
                                  ),
                                  const Text("Off"),
                                ],
                              ),
                              Wrap(
                                direction: Axis.vertical,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: -15,                                    
                                children: [
                                  Checkbox(                                      
                                    checkColor: Colors.green,
                                    activeColor: Colors.transparent, 
                                    side: MaterialStateBorderSide.resolveWith(
                                      (states) => const BorderSide(
                                        color: Colors.black,
                                        width: 2,
                                      )
                                    ),
                                    value: on,
                                    onChanged: (value) {
                                        setState(() {
                                            on = value!;
                                            off = !off;
                                        });
                                    },
                                  ),
                                  const Text("On"),
                                ],
                              ),
                            ]
                          )
                        ),
                      )
                    ]
                  )
                ]
              ),
            )
          ],
        )
      )
    );
  }
}