import 'dart:async';
import 'package:demo_app/main.dart';
import 'package:demo_app/ui/custom_widgets/custom_button.dart';
import 'package:demo_app/ui/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../custom_widgets/audiomanager.dart';
import '../custom_widgets/return_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  final bool isLoggedIn;

  const Settings({super.key, required this.isLoggedIn});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late SharedPreferences _prefs;

  int? _efeitosSonoros;
  int? _musica;
  bool? on = true;
  bool? off = false;

  bool _showFirstFrame = true; // Toggle between frames
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    initPrefs();

    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        _showFirstFrame = !_showFirstFrame;
      });
    });
  }

  void initPrefs() async {
    _prefs = await SharedPreferences.getInstance();

    _efeitosSonoros = _prefs.getInt('efeitos') ?? 7;
    _musica = _prefs.getInt('music') ?? 7;
    on = _prefs.getBool('on') ?? true;
    off = _prefs.getBool('off') ?? false;

    setState(() {});
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainMenu()),
      );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              _showFirstFrame
                  ? "assets/imgs/backgrounds/settings_1.svg"
                  : 'assets/imgs/backgrounds/settings_2.svg',
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
                      Spacer(),
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: SliderTheme(
                                      data: SliderThemeData(
                                          thumbColor: Colors.white,
                                          thumbShape:
                                              const RoundSliderThumbShape(
                                                  enabledThumbRadius: 10),
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
                                              SliderTickMarkShape.noTickMark),
                                      child: Slider(
                                        value: _efeitosSonoros?.toDouble() ?? 7,
                                        max: 10,
                                        divisions: 10,
                                        // label: _musica.round().toString(),
                                        onChanged: (double value) {
                                          setState(() {
                                            _efeitosSonoros = value.toInt();
                                            _prefs.setInt(
                                                'efeitos', _efeitosSonoros!);
                                            setState(() {});
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 25),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: const Color(0xffDADADA),
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
                                                fontFamily: 'Playpen-Sans',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: SliderTheme(
                                        data: SliderThemeData(
                                            thumbColor: Colors.white,
                                            thumbShape:
                                                const RoundSliderThumbShape(
                                                    enabledThumbRadius: 10),
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
                                                SliderTickMarkShape.noTickMark),
                                        child: Slider(
                                          value: _musica?.toDouble() ?? 7,
                                          max: 10,
                                          divisions: 10,
                                          // label: _musica.round().toString(),
                                          onChanged: (double value) {
                                            setState(() {
                                              _musica = value.toInt();
                                              _prefs.setInt('music', _musica!);
                                              AudioManager().updateVolume();
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
                                            const EdgeInsets.only(right: 25),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: const Color(0xffDADADA),
                                          ),
                                          width: 40,
                                          height: 30,
                                          child: Center(
                                            child: Text(
                                              _musica?.toInt().toString() ??
                                                  "place_holder",
                                              style: const TextStyle(
                                                  fontFamily: 'Playpen-Sans',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(),
                          ]),
                      Spacer(),
                          CustomButton(
                              label: "Sair da conta",
                              onPressed: _logout,
                              width: 180,
                            ),
                      Spacer(),
                    ]),
              )
            ],
          )
        ],
      ),
    );
  }
}
