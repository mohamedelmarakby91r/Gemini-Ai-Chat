import 'package:flutter/material.dart';
import 'package:geminiaichat/ad/AdManger.dart';
import 'package:geminiaichat/ad/admobe/Ad.dart';
import 'package:geminiaichat/get_api_key.dart';
import 'package:geminiaichat/main.dart';
import 'package:geminiaichat/text_only.dart';
import 'package:geminiaichat/text_with_image.dart';
import 'package:geminiaichat/tts_stt.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart'; // Import the url_launcher package

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _apiKeyController = TextEditingController();

  BannerAd? bannerAd;
  bool isLoaded = false;

  void load() {
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: AdManger.bannerHome,
      listener: BannerAdListener(onAdLoaded: (ad) {
        setState(() {
          isLoaded = true;
        });
      }, onAdFailedToLoad: (ad, error) {
        ad.dispose();
      }),
      request: AdRequest(),
    )..load();
  }

  @override
  void initState() {
    load();
    super.initState();
  }

  @override
  void dispose() {
    if (isLoaded) {
      bannerAd!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(148, 10, 126, 126),
        title: Text('Gemini Ai Chat', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            iconSize: 35,
            icon: Icon(themeProvider.isDarkMode
                ? Icons.wb_sunny
                : Icons.nightlight_round),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(
              flex: 1,
            ),
            Image.asset('assets/gemini ai chat splash screen.png', height: 200),
            Spacer(
              flex: 1,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 0, 150, 150)),
              onPressed: () {
                Ads().showAd();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GetAPIkey(),
                  ),
                );
              },
              child: Text('How Can You Generate Your API KEY ?',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
            TextField(
              controller: _apiKeyController,
              decoration: InputDecoration(labelText: 'your API Key'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(147, 17, 219, 219)),
              onPressed: () {
                Ads().showAd();
                setapikey().apikey = _apiKeyController.text;
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('By Your Api Key'),
                      content: Text('API Key : "${_apiKeyController.text}"'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Ads().showAd();

                            Navigator.pop(context);
                          },
                          child: Text('change Your Api Key',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 185, 185),
                                  fontSize: 16)),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(147, 17, 219, 219)),
                          onPressed: () {
                            Ads().showAd();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TextOnly(),
                              ),
                            );
                          },
                          child: Text('Start Text Only',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(147, 17, 219, 219)),
                          onPressed: () {
                            Ads().showAd();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TextWithImage(),
                              ),
                            );
                          },
                          child: Text('Start Text With Image',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('By Your Api Key',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(147, 17, 219, 219)),
              onPressed: () {
                Ads().showAd();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TextOnly(),
                  ),
                );
              },
              child: Text('Gemini AI - ( Text Only )',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(147, 17, 219, 219)),
              onPressed: () {
                Ads().showAd();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TextWithImage(),
                  ),
                );
              },
              child: Text('Gemini AI - ( Text With Image )',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 0, 150, 150)),
              onPressed: () {
                Ads().showAd();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ttsstt(),
                  ),
                );
              },
              child: Text('Convert - ( text to speech )',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
            SizedBox(
              height: 5,
            ),
            TextButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 0, 150, 150),
              ),
              onPressed: () {
                const url =
                    'https://github.com/mohamedelmarakby91r/privacy-policy/blob/master/privacy%20policy.txt'; // Replace with your external URL
                launch(url);
              },
              icon: Icon(
                Icons.open_in_browser, // Replace with your desired icon
                color: Colors.white,
                size: 35, // Adjust the size of the icon as needed
              ),
              label: Text(
                'Open privacy policy Web Page',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
                'NOTE : You can review our privacy policy \n before using the application and agree to it'),
            Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
