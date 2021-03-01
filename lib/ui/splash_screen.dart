import 'dart:async';

import 'package:colour/colour.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:zx_tape_player/ui/widgets/cassette.dart';
import 'package:zx_tape_player/utils/extensions.dart';

import 'home_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChannels.textInput
        .invokeMethod('TextInput.hide'); // hide the keyboard
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (BuildContext context) {
              return HomeScreen();
            })));

    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(children: <Widget>[
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Cassette(),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Text(tr('zx_tape_player'),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 22, color: Colour('##E7ECED')))),
                    ],
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                  child: Column(children: <Widget>[
                    FutureBuilder<PackageInfo>(
                      builder: (BuildContext context,
                          AsyncSnapshot<PackageInfo> snapshot) {
                        var copyrightText = tr('copyright');
                        if (snapshot.hasData) {
                          copyrightText += tr('version').format([
                            snapshot.data.version,
                            snapshot.data.buildNumber
                          ]);
                        }
                        return Text(copyrightText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                                height: 1.8,
                                color: Colour('#AFB6BB')));
                      },
                      future: PackageInfo.fromPlatform(),
                    ),
                  ]))
            ])));
  }
}
