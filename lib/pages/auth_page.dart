import 'package:flutter/material.dart';
import '../components/buttons/accent_button.dart';

class AuthPage extends StatefulWidget {
@override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage>{
  //STATES
  String _email = '';
  String _password = '';
  //METHODS
  void _login(context){
    print(_email+' '+_password);
    Navigator.pushReplacementNamed(context, '/home');
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
    return Scaffold(
      body: Container(
        //ContainerStyle
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/delo.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.2),
              BlendMode.dstATop,
            ),
          ),
        ),
        padding: const EdgeInsets.all(8.0),
        //ContainerContent
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                //E-MAIL
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (String value){
                      setState(() {
                        _email = value;
                      });
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                      labelText: 'E-mail',
                      hintText: 'user@email.com',
                      icon: Icon(Icons.mail),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ),
                //PASSWORD
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (String value){
                      setState(() {
                        _password = value;
                      });
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                      labelText: 'Password',
                      icon: Icon(Icons.vpn_key),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ),
                //Login Button
                Padding(
                  padding: EdgeInsets.only(left: 100.0, right: 100.0),
                  child: AccentButton(buttonName: 'Login', buttonPress: _login, data: context),
                ),
              ],
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