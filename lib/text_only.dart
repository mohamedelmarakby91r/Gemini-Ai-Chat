import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:geminiaichat/ad/admobe/Ad.dart';
import 'package:geminiaichat/main.dart';
import 'package:geminiaichat/text_with_image.dart';
import 'package:geminiaichat/tts_stt.dart';
import 'package:google_gemini/google_gemini.dart';
import 'package:share_plus/share_plus.dart';

class TextOnly extends StatefulWidget {
  const TextOnly({
    super.key,
  });

  @override
  State<TextOnly> createState() => _TextOnlyState();
}

class _TextOnlyState extends State<TextOnly> {
  bool loading = false;
  List textChat = [];
  List textWithImageChat = [];

  final TextEditingController _textController = TextEditingController();
  final ScrollController _controller = ScrollController();

  final commonTextStyle = TextStyle(fontSize: 15);

  // Create Gemini Instance
  final gemini = GoogleGemini(
    apiKey: apiKey,
  );

  // Text only input
  void fromText({required String query}) {
    setState(() {
      loading = true;
      textChat.add({
        "role": "User",
        "text": query,
      });
      _textController.clear();
    });
    scrollToTheEnd();

    gemini.generateFromText(query).then((value) {
      setState(() {
        loading = false;
        textChat.add({
          "role": "Gemini",
          "text": value.text,
        });
      });
      scrollToTheEnd();
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
        textChat.add({
          "role": "Gemini",
          "text": error.toString(),
        });
      });
      scrollToTheEnd();
    });
  }

  void scrollToTheEnd() {
    _controller.jumpTo(_controller.position.maxScrollExtent);
  }

  TextEditingController textcontroller =
      TextEditingController(text: 'Write some text for speech');

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
          title: const Text("Text Only",
              style: TextStyle(color: Colors.white, fontSize: 22)),
          centerTitle: true,
          actions: [
            IconButton(
              color: Colors.white,
              icon: Icon(
                Icons.content_copy,
              ), // رمز النسخ
              onPressed: () {
                Ads().showAd();
                // التحقق من وجود نص للنسخ
                if (textChat.isNotEmpty && textChat.last.containsKey("text")) {
                  String textToCopy = textChat.last["text"];

                  // نسخ النص إلى الحافظة
                  Clipboard.setData(ClipboardData(text: textToCopy));

                  // إظهار رسالة تأكيد
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('تم نسخ النص إلى الحافظة')),
                  );

                  // الانتقال إلى صفحة جديدة
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          TextWithImage(), // استبدل NewPage() بصفحتك الجديدة
                    ),
                  );
                } else {
                  // إظهار رسالة بأنه لا يوجد نص للنسخ
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('لا يوجد نص للنسخ')),
                  );
                }
              },
            ),
            IconButton(
              color: Colors.white,
              icon: const Icon(Icons.share), // رمز المشاركة
              onPressed: () {
                Ads().showAd();
                // التحقق من وجود نص للمشاركة
                if (textChat.isNotEmpty && textChat.last.containsKey("text")) {
                  String textToShare = textChat.last["text"];

                  // مشاركة النص عبر وسائل التواصل الاجتماعي
                  Share.share(textToShare);
                } else {
                  // إظهار رسالة بأنه لا يوجد نص للمشاركة
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('لا يوجد نص للمشاركة')),
                  );
                }
              },
            ),
            IconButton(
              color: Colors.white,
              icon: const Icon(Icons.volume_up), // أيقونة التحويل إلى صوت
              onPressed: () {
                Ads().showAd();
                // الانتقال إلى صفحة جديدة
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ttsstt(), // استبدل NewPage() بصفحتك الجديدة
                  ),
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            SelectableText(
              '',
              style: commonTextStyle,
            ),
            Expanded(
              child: ListView.builder(
                controller: _controller,
                itemCount: textChat.length,
                padding: const EdgeInsets.only(bottom: 20, left: 15, right: 7),
                itemBuilder: (context, index) {
                  return SelectableText.rich(
                    TextSpan(
                      children: [
                        WidgetSpan(
                          child: CircleAvatar(
                            child:
                                Text(textChat[index]["role"].substring(0, 1)),
                          ),
                        ),
                        TextSpan(
                          text: textChat[index]["text"],
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: "Type a message",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none),
                        fillColor: Colors.transparent,
                      ),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                  IconButton(
                    icon: loading
                        ? const CircularProgressIndicator()
                        : const Icon(Icons.send),
                    onPressed: () {
                      fromText(query: _textController.text);
                    },
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
