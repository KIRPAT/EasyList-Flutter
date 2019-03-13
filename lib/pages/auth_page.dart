import 'package:flutter/material.dart';
//Components
import '../components/buttons/accent_button.dart';
//Helpers
import '../helpers/RegExpLib.dart';

class AuthPage extends StatefulWidget {
@override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage>{
  //STATES
  final Map<String, dynamic> _loginFormData = {
    'email': null,
    'password': null,
    'acceptTerms': false
  };
  final GlobalKey<FormState> _loginFormKey = new GlobalKey<FormState>();

  //METHODS
  void _login(context){
    if (!_loginFormKey.currentState.validate() || !_loginFormData['acceptTerms']){return;}
    _loginFormKey.currentState.save();
    print(_loginFormData); //Dummy Code
    Navigator.pushReplacementNamed(context, '/home');
  }

  //STYLE COMPONENTS
  InputDecoration _loginFormInputDecoration(String labelText, String hintText, IconData fieldIcon) {
    return InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      labelText: labelText,
      hintText: hintText,
      icon: Icon(fieldIcon),
      filled: true,
      fillColor: Colors.white.withOpacity(0.8),
    );
  }
  BoxDecoration _loginPageBoxDecoration (String assetDirectory){
    return BoxDecoration(
      image: DecorationImage(
        image: AssetImage(assetDirectory),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.2),
          BlendMode.dstATop,
        ),
      ),
    );
  }
  //WIDGETS
  /*
  Note_1: ScrollView takes all the possible empty space.

  If I reserve the whole body to ListView, I can not center anything.
  There are two solutions. Either I make a SingleChildScrollView and place a Column in it.
  Basically I'm making a listView that takes as much space as it's length allows it to.
  The height becomes dynamic. For a fixed length list, it is good.
  For a list that can be shorter than the screen height though, it can be a problem.

  To test how it reacts to a huge height content,
  place a SizedBox(height: 1000.0) before E-Mail TextInput View.

  Second solution is similar to first one but the list height is not dynamic this time.
  Wrap the ListView with a Sized Box. Basically make the Sized box the new body.
  Then wrap that with Center widget. Problem is focus.
  */
  Widget authPageRender(BuildContext context){
    final _width = MediaQuery.of(context).size.width;
    final _targetWidth = _width > 500.0 ? _width * 0.6 : _width * 0.9;

    return Scaffold(
      body: GestureDetector(
        onTap: (){FocusScope.of(context).requestFocus(FocusNode());}, //close keyboard on empty space tap
        child: Container(
          //ContainerStyle
          decoration: _loginPageBoxDecoration('assets/delo.jpg'),
          padding: const EdgeInsets.all(8.0),
          //ContainerContent
          child: Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Container(
                width: _targetWidth, //Always %80 of the available width.
                child: Form(
                  key: _loginFormKey,
                  child: Column(
                    children: <Widget>[
                      //E-MAIL
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (String value){
                            if (value.isEmpty || !RegExp(regLib['email']).hasMatch(value)) {
                              return 'Please enter a valid E-mail.';
                              //Note: Database query for user login is required.
                            }
                          },
                          decoration: _loginFormInputDecoration('E-mail', 'user@email', Icons.mail),
                          onSaved: (String value){_loginFormData['email']= value;},
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      //PASSWORD
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (String value){
                            if (value.isEmpty || value.length < 6) {
                              return 'Please enter a valid password.';
                              //Note: Database query for user login is required.
                            }
                          },
                          decoration: _loginFormInputDecoration('password', 'A-z, 0-9, -_,', Icons.vpn_key),
                          onSaved: (String value){_loginFormData['password'] = value;},
                          obscureText: true,
                        ),
                      ),
                      //Login Button
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: SizedBox()
                          ),
                          Expanded(
                            flex: 3,
                            child: SwitchListTile(
                              title: Text('Terms of Service'),
                              value: _loginFormData['acceptTerms'],
                              onChanged: (bool value){
                                setState(() {
                                  _loginFormData['acceptTerms'] = value;
                                });
                              }
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 100.0, right: 100.0),
                        child: AccentButton(buttonName: 'Login', buttonPress: _login, data: context),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  //BUILD
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return authPageRender(context);
  }
}