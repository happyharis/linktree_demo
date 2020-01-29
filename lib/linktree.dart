// import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:linktree_demo_clone/maps.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

class Linktree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          SizedBox(height: 35),
          FadeInImage.memoryNetwork(
            image: 'https://i.ibb.co/LnFqnFs/profilepic2.png',
            placeholder: kTransparentImage,
            width: 96,
            height: 96,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
            child: Text(
              '@thehappyharis',
              style: TextStyle(
                fontFamily: 'Karla',
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(height: 20),
          ButtonLink(
            text: 'Youtube',
            url: 'https://www.youtube.com/watch?v=TeLEfZhPkhw',
          ),
          ButtonLink(
            text: 'LinkedIn',
            url:
                'https://www.linkedin.com/in/muhammad-haris-bin-samingan-7889b9140/',
          ),
          ButtonLink(
            text: 'Podcast',
            url: 'https://open.spotify.com/show/2UgZ6r1bY8Gtf1FbzhRNo6',
          ),
          ButtonLink(
            text: 'Medium',
            url: 'https://medium.com/@muhamad_haris',
          ),
          Container(
            height: 300,
            child: GoogleMap(),
          ),
          Spacer(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Built in Flutter',
                style: TextStyle(
                  fontFamily: 'Karla',
                  color: Colors.black,
                  fontSize: 19,
                ),
              ),
              SizedBox(width: 7),
              FadeInImage.memoryNetwork(
                image:
                    'https://www.didierboelens.com/images/hummingbird_logo.png',
                placeholder: kTransparentImage,
                width: 25,
                height: 25,
              ),
            ],
          ),
          SizedBox(height: 23)
        ],
      ),
    );
  }
}

class ButtonLink extends StatelessWidget {
  const ButtonLink({
    Key key,
    @required this.text,
    @required this.url,
  }) : super(key: key);
  final String text;
  final String url;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        child: FlatButton(
          color: Color.fromRGBO(57, 224, 155, 1),
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'Karla',
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          // onPressed: () => html.window.location.href = url,
          onPressed: () => launch(url),
        ),
      ),
    );
  }
}
