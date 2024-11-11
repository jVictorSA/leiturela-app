import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../custom_widgets/return_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late SharedPreferences _prefs;

  int? _efeitosSonoros;
  int? _musica;
  bool? on = true;
  bool? off = false;

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  void initPrefs() async {
    _prefs = await SharedPreferences.getInstance();

    _efeitosSonoros = _prefs.getInt('efeitos') ?? 7;
    _musica = _prefs.getInt('music') ?? 7;
    on = _prefs.getBool('on') ?? true;
    off = _prefs.getBool('off') ?? false;

    setState(() {});
  }
  void increaseVibration() {
    setState(() {
      if (off == true) {
        off = false;
        on = true;
      } else {
        on = true;
      }
      _prefs.setBool('on', on!);
      _prefs.setBool('off', off!);
    });
  }

  void decreaseVibration() {
    setState(() {
      if (on == true) {
        on = false;
        off = true;
      } else {
        off = true;
      }
      _prefs.setBool('on', on!);
      _prefs.setBool('off', off!);
    });
  }

  void increaseVolumeEfeitos() {
    setState(() {
      if (_efeitosSonoros! < 10) {
        _efeitosSonoros = _efeitosSonoros! + 1;
        _prefs.setInt('efeitos', _efeitosSonoros!);
      }
    });
  }

  void decreaseVolumeEfeitos() {
    setState(() {
      if (_efeitosSonoros! > 0) {
        _efeitosSonoros = _efeitosSonoros! - 1;
        _prefs.setInt('efeitos', _efeitosSonoros!);
      }
    });
  }

  // Funções para aumentar e diminuir o volume da música
  void increaseVolumeMusica() {
    setState(() {
      if (_musica! < 10) {
        _musica = _musica! + 1;
        _prefs.setInt('music', _musica!);
      }
    });
  }

  void decreaseVolumeMusica() {
    setState(() {
      if (_musica! > 0) {
        _musica = _musica! - 1;
        _prefs.setInt('music', _musica!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              "assets/imgs/background.svg",
              // Update with your SVG path
              fit: BoxFit.cover, // Same as the fit you used for PNG
            ),
          ),
          Column(
            children: [
              Row(children: [ReturnButton(parentContext: context)]),
              Expanded(
                child: Column(
                    // mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Expanded(
                              flex: 1,
                              child: Text(
                                "Efeitos Sonoros",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontFamily: 'Playpen-Sans',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: SizedBox(
                                    width: 100,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: SliderTheme(
                                              data: SliderThemeData(
                                                  thumbColor: Colors.white,
                                                  thumbShape:
                                                      const RoundSliderThumbShape(
                                                          enabledThumbRadius:
                                                              10),
                                                  activeTrackColor:
                                                      const Color(0xff012480),
                                                  inactiveTrackColor:
                                                      const Color(0xff012480),
                                                  trackHeight: 8,
                                                  trackShape:
                                                      const RoundedRectSliderTrackShape(),
                                                  showValueIndicator:
                                                      ShowValueIndicator.never,
                                                  tickMarkShape:
                                                      SliderTickMarkShape
                                                          .noTickMark),
                                              child: Slider(
                                                value: _efeitosSonoros
                                                        ?.toDouble() ??
                                                    7,
                                                max: 10,
                                                divisions: 10,
                                                // label: _musica.round().toString(),
                                                onChanged: (double value) {
                                                  setState(() {
                                                    _efeitosSonoros =
                                                        value.toInt();
                                                    _prefs.setInt('efeitos',
                                                        _efeitosSonoros!);
                                                    setState(() {});
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              flex: 1,
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 25),
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: const Color(
                                                            0xffDADADA),
                                                      ),
                                                      width: 30,
                                                      height: 30,
                                                      child: Center(
                                                          child: Text(
                                                        _efeitosSonoros
                                                                ?.toInt()
                                                                .toString() ??
                                                            "place_holder",
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'Playpen-Sans',
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      )))))
                                        ]))),
                          Spacer(),
                          ],),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Expanded(
                              flex: 1,
                              child: Text(
                                "Música",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontFamily: 'Playpen-Sans',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: SizedBox(
                                    width: 300,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: SliderTheme(
                                              data: SliderThemeData(
                                                  thumbColor: Colors.white,
                                                  thumbShape:
                                                      const RoundSliderThumbShape(
                                                          enabledThumbRadius:
                                                              10),
                                                  activeTrackColor:
                                                      const Color(0xff012480),
                                                  inactiveTrackColor:
                                                      const Color(0xff012480),
                                                  trackHeight: 8,
                                                  trackShape:
                                                      const RoundedRectSliderTrackShape(),
                                                  showValueIndicator:
                                                      ShowValueIndicator.never,
                                                  tickMarkShape:
                                                      SliderTickMarkShape
                                                          .noTickMark),
                                              child: Slider(
                                                value: _musica?.toDouble() ?? 7,
                                                max: 10,
                                                divisions: 10,
                                                // label: _musica.round().toString(),
                                                onChanged: (double value) {
                                                  setState(() {
                                                    _musica = value.toInt();
                                                    _prefs.setInt(
                                                        'music', _musica!);
                                                    setState(() {});
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              flex: 1,
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 25),
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: const Color(
                                                            0xffDADADA),
                                                      ),
                                                      width: 40,
                                                      height: 30,
                                                      child: Center(
                                                          child: Text(
                                                        _musica
                                                                ?.toInt()
                                                                .toString() ??
                                                            "place_holder",
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'Playpen-Sans',
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      )))))
                                        ]))),
                            const Spacer(),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Expanded(
                              flex: 1,
                              child: Text(
                                "Vibrações",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontFamily: 'Playpen-Sans',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: SizedBox(
                                  width: 300,
                                  child: Row(children: [
                                    Wrap(
                                      direction: Axis.vertical,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      spacing: -15,
                                      children: [
                                        Checkbox(
                                          checkColor: Colors.green,
                                          activeColor: Colors.transparent,
                                          side: MaterialStateBorderSide
                                              .resolveWith(
                                                  (states) => const BorderSide(
                                                        color: Colors.black,
                                                        width: 2,
                                                      )),
                                          value: off,
                                          onChanged: (value) {
                                            setState(() {
                                              off = value!;
                                              on = !on!;
                                              _prefs.setBool('off', off!);
                                              _prefs.setBool('on', on!);
                                            });
                                          },
                                        ),
                                        const Text("Off"),
                                      ],
                                    ),
                                    Wrap(
                                      direction: Axis.vertical,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      spacing: -15,
                                      children: [
                                        Checkbox(
                                          checkColor: Colors.green,
                                          activeColor: Colors.transparent,
                                          side: MaterialStateBorderSide
                                              .resolveWith(
                                                  (states) => const BorderSide(
                                                        color: Colors.black,
                                                        width: 2,
                                                      )),
                                          value: on,
                                          onChanged: (value) {
                                            setState(() {
                                              on = value!;
                                              off = !off!;
                                              _prefs.setBool('on', on!);
                                              _prefs.setBool('off', off!);
                                            });
                                          },
                                        ),
                                        const Text("On"),
                                      ],
                                    ),
                                  ])),
                            ),
                            const Spacer()
                          ])   
                    ]),
                    
              )
            ],
          )
        ],
      ),
    );
  }
}
