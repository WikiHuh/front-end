import 'package:flutter/material.dart';
import 'package:wikihuh/pages/page_wrapper.dart';
import 'package:wikihuh/sockets.dart';
import 'package:wikihuh/widgets/buttons.dart';
import 'package:wikihuh/widgets/shadows.dart';

class EnterPinPage extends StatefulWidget {
  final String name;

  EnterPinPage({@required this.name});

  @override
  _EnterPinPageState createState() => _EnterPinPageState();
}

class _EnterPinPageState extends State<EnterPinPage> {
  List<String> _pin;
  final List<FocusNode> focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  @override
  void initState() {
    _pin = ['', '', '', '', '', ''];
    super.initState();
  }

  void onSubmit() {
    CurrentGame.of(context).send('join-game', {'pin': _pin.join(), 'name': this.widget.name});
  }

  void onChanged(String v, int i) {
    setState(() {
      _pin[i] = v;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      child: SingleChildScrollView(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(30, 50, 30, 0),
                alignment: Alignment.centerLeft,
                child: Text('Enter Pin', style: Theme.of(context).textTheme.display4, textAlign: TextAlign.center,),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SingleCharInput(onChanged: (String v) => onChanged(v, 0), thisField: focusNodes[0], nextField: focusNodes[1]),
                    SingleCharInput(onChanged: (String v) => onChanged(v, 1), thisField: focusNodes[1], nextField: focusNodes[2]),
                    SingleCharInput(onChanged: (String v) => onChanged(v, 2), thisField: focusNodes[2], nextField: focusNodes[3]),
                    SingleCharInput(onChanged: (String v) => onChanged(v, 3), thisField: focusNodes[3], nextField: focusNodes[4]),
                    SingleCharInput(onChanged: (String v) => onChanged(v, 4), thisField: focusNodes[4], nextField: focusNodes[5]),
                    SingleCharInput(onChanged: (String v) {
                      onChanged(v, 5);
                      onSubmit();
                    }, thisField: focusNodes[5], lastField: true,),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Button2(text: 'Submit', onPressed: onSubmit)
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: Button3(text: 'Back', onPressed: () => Navigator.of(context).pop(),)
              )
            ],
          ),
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class SingleCharInput extends StatefulWidget {
  final Function(String) onChanged;
  final bool lastField;
  final FocusNode thisField;
  final FocusNode nextField;

  SingleCharInput({this.onChanged, this.thisField, this.nextField, this.lastField = false});

  @override
  _SingleCharInputState createState() => _SingleCharInputState();
}

class _SingleCharInputState extends State<SingleCharInput> {
  String _currentChar = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 56,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          DropShadow(),
          ShadowFrame(fgColor: Colors.white, height: 3),
        ]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: TextFormField(
          focusNode: this.widget.thisField,
          keyboardType: TextInputType.number,
          onChanged: (String newChar) {
            print(newChar);
            setState(() {
              _currentChar = newChar;
            });
            this.widget.onChanged(newChar);
            if (newChar.length == 1) {
              this.widget.thisField.unfocus();
              FocusScope.of(context).requestFocus(this.widget.nextField);
            }
          },
          onFieldSubmitted: (String s) {
            if (!this.widget.lastField && _currentChar.length == 1) {
              this.widget.thisField.unfocus();
              FocusScope.of(context).requestFocus(this.widget.nextField);
            }
          },
          style: Theme.of(context).textTheme.body1.copyWith(fontSize: 25),
          maxLength: 1,
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.center,
          textInputAction: this.widget.lastField ? TextInputAction.done : TextInputAction.next,
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Colors.white,
            focusColor: Colors.white,
            filled: true,
            counterText: "",
          ),
        ),
      ),
    );
  }
}