import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ttsstt extends StatefulWidget {
  const ttsstt({super.key});

  @override
  State<ttsstt> createState() => ttssttState();
}

class ttssttState extends State<ttsstt> {

  TextEditingController textcontroller = TextEditingController(text: '');


  FlutterTts flutterTts = FlutterTts();
  double volumerange = 0.5;
  double pitchrange = 1;
  double speechrange = 0.5;
  bool isSpeaking = false;

  play() async {
    final languages = await flutterTts.getLanguages;
    print(languages);
    await flutterTts.setLanguage(languages[23]);
    final voices = await flutterTts.getVoices;
    print(voices);
    await flutterTts.setVoice({"name": "hi-in-x-hia-local", "locale": "hi-IN"});
    await flutterTts.speak(textcontroller.text);
    isSpeaking = true;
    setState(() {});
  }

  stop() async {
    await flutterTts.stop();
    isSpeaking = false;
    setState(() {});
  }

  pause() async {
    await flutterTts.pause();
    isSpeaking = false;
    setState(() {});
  }

  volume(val) async {
    volumerange = val;
    await flutterTts.setVolume(volumerange);
    setState(() {});
  }

  pitch(val) async {
    pitchrange = val;
    await flutterTts.setPitch(pitchrange);
    setState(() {});
  }

  speech(val) async {
    speechrange = val;
    await flutterTts.setSpeechRate(speechrange);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(148, 10, 126, 126),
        centerTitle: true,
        title: const Text(
          'Text To Speech & Speech To Text',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              width: 250,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color.fromARGB(148, 10, 126, 126),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: textcontroller,
                      maxLines: null,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1)),
                      decoration: const InputDecoration(
                        hintText: 'Write some text',
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.paste, color: Colors.white),
                    onPressed: () async {
                      ClipboardData? data =
                          await Clipboard.getData('text/plain');
                      if (data != null && data.text != null) {
                        setState(() {
                          textcontroller.text = data.text!;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            AvatarGlow(
                animate: isSpeaking,
                glowColor: Color.fromARGB(255, 243, 33, 33),
                child: Material(
                  elevation: 10,
                  shape: CircleBorder(),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Color.fromARGB(255, 247, 113, 95),
                    child: Icon(
                      Icons.volume_up_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                endRadius: 70),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    splashRadius: 40,
                    onPressed: play,
                    color: Color.fromARGB(199, 255, 217, 0),
                    iconSize: 60,
                    icon: const Icon(Icons.play_circle)),
                IconButton(
                    onPressed: stop,
                    color: Color.fromARGB(144, 23, 201, 32),
                    splashRadius: 40,
                    iconSize: 60,
                    icon: const Icon(Icons.stop_circle)),
                IconButton(
                    onPressed: pause,
                    color: Color.fromARGB(209, 0, 174, 255),
                    splashRadius: 40,
                    iconSize: 60,
                    icon: const Icon(Icons.pause_circle)),
              ],
            ),
            Slider(
              max: 1,
              value: volumerange,
              onChanged: (value) {
                volume(value);
              },
              divisions: 10,
              label: "Volume: $volumerange",
              activeColor: Color.fromARGB(199, 255, 217, 0),
            ),
            const Text('Set Volume'),
            Slider(
              max: 2,
              value: pitchrange,
              onChanged: (value) {
                pitch(value);
              },
              divisions: 10,
              label: "Pitch Rate: $pitchrange",
              activeColor: Color.fromARGB(144, 23, 201, 32),
            ),
            const Text('Set Pitch'),
            Slider(
              max: 1,
              value: speechrange,
              onChanged: (value) {
                speech(value);
              },
              divisions: 10,
              label: "Speech rate: $speechrange",
              activeColor: Color.fromARGB(209, 0, 174, 255),
            ),
            const Text('Set Speech Rate'),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
