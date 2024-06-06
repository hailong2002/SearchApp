import 'package:flutter/material.dart';
import 'package:search_app/repository/repository.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../Shared/widgets.dart';
import '../model/address.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String keyword = "";
  TextEditingController controller = TextEditingController();
  bool loading = false;
  final MyRepository repository = MyRepository();
  List<Address> result = [];
  List<RichText> richTexts = [];

  static Future<void> openGoogleMap(String address) async {
    final Uri googleMapsUrl = Uri.parse('https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}');
    if (await canLaunchUrlString(googleMapsUrl.toString())) {
      await launchUrlString(googleMapsUrl.toString());
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }

  List<RichText> highlightKeyword(String text)
  {
    String cleanedKeyword = keyword.replaceAll(RegExp(r'[^\p{L}\p{N}\s]', unicode: true), '').toLowerCase();
    richTexts = [];
    for(var r in result){
      List<TextSpan> spans = [];
      for(String word in r.label.split(' '))
      {
        String cleanedWord = word.replaceAll(RegExp(r'[^\p{L}\p{N}\s]', unicode: true), '').toLowerCase();
        TextSpan textSpan = TextSpan(text: word + ' ',
          style: TextStyle(color: cleanedWord.contains(cleanedKeyword) || cleanedKeyword.contains(cleanedWord) ? Colors.black: Colors.grey));
        spans.add(textSpan);
      }
      RichText richText = RichText(text: TextSpan(children: spans));
      richTexts.add(richText);
    }
    return richTexts;
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: 900,
          child: Padding(
            padding: const EdgeInsets.only(top:80, left: 20, right: 20, bottom: 10),
            child: Column(
                children: [
                  //search bar
                  TextFormField(
                    controller: controller,
                    cursorHeight: 21,
                    cursorColor: Colors.black,
                    textInputAction: TextInputAction.search,
                    decoration: searchBarDecoration.copyWith(
                    prefixIcon: !loading ? const Icon(Icons.search, color: Colors.black) : const CircularProgressIndicator()
                    ),
                    onChanged: (text) async{
                      loading = true;
                      var data = await repository.loadData(text);
                      setState((){
                        keyword = text;
                        if(data!.isNotEmpty)
                        {
                          result = data;
                          richTexts = highlightKeyword(text);
                        }
                        loading = false;
                      });
                    },
                  ),
                  
                  // Show result
                  Container(
                    height: 380,
                    child: ListView.builder(
                        itemCount: result.length,
                        itemBuilder: (context, index){
                          return  ListTile(
                            leading: const Icon(Icons.location_on_outlined),
                            title: richTexts[index],
                              trailing: IconButton(
                                onPressed: (){
                                  openGoogleMap(result[index].label);
                                },
                                icon: const Icon(Icons.turn_right_rounded),
                              ) ,

                          );
                        }
                    ),
                  )
                  
                ],
            ),
          ),
      ),
    );
  }
}
