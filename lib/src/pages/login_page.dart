import 'package:flutter/material.dart';
import 'package:petbook_app/src/providers/firepets_provider.dart';
import 'package:petbook_app/src/providers/user_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final UserProvider _userProvider = UserProvider();
  final formKey = GlobalKey<FormState>();

  String email;
  String password;
  String password2;

  bool register = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _getAppBar(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height - 60,
          ),
          child: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        _getTitle(context, register ? 'Sign Up' : 'Sign In'),
                        _getEmail(),
                        _getPassword(),
                        Visibility(visible: register, child: _getPassword2()),
                        Visibility(
                            visible: register,
                            child: _getRegisterButton(context)),
                        Visibility(
                          visible: !register,
                          child: _getButtons(context),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: !register,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _getSubTitle(context),
                      _getLookButton(context),
                      Image(
                        image: AssetImage('assets/images/takeALook.jpg'),
                        width: double.infinity,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _getAppBar(BuildContext context) {
    return AppBar(
      brightness: Brightness.light,
      titleSpacing: 18,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Image(
        image: AssetImage('assets/images/logotype.png'),
        height: 30,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _getTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          text: title,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).primaryColorDark,
          ),
          children: [
            TextSpan(
              text: '.',
              style: TextStyle(
                fontSize: 44,
                fontWeight: FontWeight.w900,
                height: .6,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getEmail() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        textCapitalization: TextCapitalization.none,
        decoration: InputDecoration(labelText: 'E-mail'),
        onSaved: (value) => email = value,
        validator: (String value) {
          if (value.length < 3) return 'Enter your E-mail';
          if (!RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value)) return 'Enter a Valid E-mail';
          return null;
        },
      ),
    );
  }

  Widget _getPassword() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        obscureText: true,
        textCapitalization: TextCapitalization.none,
        decoration: InputDecoration(labelText: 'Password'),
        onSaved: (value) => password = value,
        validator: (String value) {
          if (value.length < 6)
            return 'Enter your Password (At Least 6 Characters)';
          return null;
        },
      ),
    );
  }

  Widget _getPassword2() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        obscureText: true,
        textCapitalization: TextCapitalization.none,
        decoration: InputDecoration(labelText: 'Confirm Password'),
        onSaved: (value) => password2 = value,
        validator: (String value) {
          if (value.length < 6)
            return 'Enter your Password (At Least 6 Characters)';
          return null;
        },
      ),
    );
  }

  Widget _getButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 56.0),
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              child: Text('Lets Find Your Friend!'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(12),
                primary: Theme.of(context).primaryColor,
                textStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 18),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: () async {
                if (!_validarForm(context)) return;

                final response =
                    await _userProvider.ingresarUsuario(email, password);

                if (response == 1) {
                  Provider.of<FirepetsProvider>(context, listen: false).email =
                      this.email;
                  Navigator.pushNamed(context, '/');
                  return;
                }

                if (response == _userProvider.EMAIL_NOT_FOUND) {
                  final snackBar =
                      SnackBar(content: Text('E-mail was not found'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  return;
                }

                if (response == _userProvider.INVALID_PASSWORD) {
                  final snackBar =
                      SnackBar(content: Text('Incorrect Password'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  return;
                }

                final snackBar = SnackBar(
                    content: Text('Something Went Wrong! Try Again Later'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              child: Text(
                'Want to Get an Account?',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                    fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(12),
                primary: Colors.white,
                side: BorderSide(
                  width: 2,
                  color: Theme.of(context).primaryColor,
                ),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                setState(() {
                  register = true;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  bool _validarForm(BuildContext context) {
    if (!formKey.currentState.validate()) {
      final snackBar =
          SnackBar(content: Text('Please Enter Yout Account Info'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
    formKey.currentState.save();
    return true;
  }

  Widget _getSubTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          text: 'Just Want to Take a Look',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).primaryColorDark,
          ),
          children: [
            TextSpan(
              text: '?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                height: .6,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getRegisterButton(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 56),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              child: Text(
                'Lets Get Into It!',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(12),
                primary: Theme.of(context).primaryColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: () async {
                if (!_validarForm(context)) return;

                if (password.compareTo(password2) != 0) {
                  final snackBar =
                      SnackBar(content: Text('Passwords do not match'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  return;
                }

                if (await _userProvider.registrarUsuario(email, password)) {
                  Provider.of<FirepetsProvider>(context, listen: false).email =
                      this.email;
                  Navigator.pushNamed(context, '/');
                  return;
                } else {
                  final snackBar = SnackBar(
                      content: Text('This E-mail is Already Registered'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              child: Text(
                'Go Back',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                    fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(12),
                primary: Colors.white,
                side: BorderSide(
                  width: 2,
                  color: Theme.of(context).primaryColor,
                ),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                setState(() {
                  register = false;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _getLookButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          child: Text(
            'Go Ahead!',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor,
                fontSize: 18),
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(12),
            primary: Colors.white,
            side: BorderSide(
              width: 2,
              color: Theme.of(context).primaryColor,
            ),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: () async {
            Provider.of<FirepetsProvider>(context, listen: false).email =
                this.email;
            Navigator.pushNamed(context, '/');
          },
        ),
      ),
    );
  }
}
