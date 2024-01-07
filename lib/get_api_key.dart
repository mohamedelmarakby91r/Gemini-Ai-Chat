import 'package:flutter/material.dart';

class GetAPIkey extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final commonTextStyle = TextStyle(fontSize: 15);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(148, 10, 126, 126),
          title: Text('Get API key', style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                SelectableText(
                  '1/ The first step:\n You can go through the following link to the service provided by Google to create your API key :\n     https://makersuite.google.com/app/apikey',
                  style: commonTextStyle,
                ),
                SizedBox(height: 10),
                SelectableText(
                  '2/ The second step:\n You can log in with your account or create an account to log in',
                  style: commonTextStyle,
                ),
                SizedBox(height: 10),
                SelectableText(
                  '3/ Step Three:\n Click on Get API key, then click on Create API key in new project',
                  style: commonTextStyle,
                ),
                SizedBox(height: 10),
                SelectableText(
                  '4/ Fourth step:\n You can copy your API key and then put it in the your API key input field',
                  style: commonTextStyle,
                ),
                SizedBox(height: 10),
                SelectableText(
                  '-: Important Alert : -',
                  style: commonTextStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                SelectableText(
                  'Please review the Google Cloud Platform Terms of Service :\n            https://cloud.google.com/terms',
                  style: commonTextStyle,
                ),
                SizedBox(height: 10),
                SelectableText(
                  'Please see Google privacy policy:\n            https://policies.google.com/privacy',
                  style: commonTextStyle,
                ),
                SizedBox(height: 10),
                SelectableText(
                  'Please review the Terms of Service:\n        https://policies.google.com/terms?hl=ar',
                  style: commonTextStyle,
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
