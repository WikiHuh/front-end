import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wikihuh/pages/enter_pin.dart';
import 'package:wikihuh/pages/page_wrapper.dart';
import 'package:wikihuh/sockets.dart';
import 'package:wikihuh/widgets/buttons.dart';
import 'package:wikihuh/widgets/dialogs.dart';
import 'package:wikihuh/widgets/shadows.dart';
import 'package:wikihuh/widgets/wikihuh_logo.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _name;
  TextEditingController _controller;
  SharedPreferences _prefs;

  @override
  void initState() {
    _name = '';
    _controller = TextEditingController();
    SharedPreferences.getInstance().then((p) {
      setState(() {
        _prefs = p;
        _name = _prefs.getString('name');
        _controller.text = _name;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      child: Center(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                WikihuhLogo(),
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 30),
                  decoration: BoxDecoration(
                    boxShadow: [
                      DropShadow()
                    ]
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: TextFormField(
                      onChanged: (String val) {
                        setState(() {
                          _name = val;
                        });
                      },
                      style: Theme.of(context).textTheme.body1,
                      decoration: InputDecoration(
                        hintText: 'Nickname',
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        border: InputBorder.none,
                        fillColor: Colors.white,
                        focusColor: Colors.white,
                        filled: true,
                      ),
                      maxLines: 1,
                      controller: _controller,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Button1(text: 'Create Game', onPressed: () {
                    if ((_name??'').isNotEmpty) {
                      _prefs?.setString('name', _name);
                      CurrentGame.of(context).send('create-game', {'name': _name});
                    } else {
                      showDialog(context: context, builder: (context) => ErrorDialog(context, 'Please enter a name!'));
                    }
                  },),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 30),
                  child: Button1(text: 'Join Game', onPressed: () {
                    if ((_name??'').isNotEmpty) {
                      _prefs?.setString('name', _name);
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => EnterPinPage(name: _name)));
                    } else {
                      showDialog(context: context, builder: (context) => ErrorDialog(context, 'Please enter a name!'));
                    }
                  },),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}