part of 'package:validus_otp_demo/app.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();
  String phoneNumber = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Login',
                style: TextStyle(fontSize: 40),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "We'll send an SMS with a verification code...",
                style: TextStyle(fontSize: 22),
              ),
              const SizedBox(height: 15),
              EasyContainer(
                elevation: 0,
                borderRadius: 10,
                color: Colors.transparent,
                child: Form(
                  key: _formKey,
                  child: IntlPhoneField(
                    invalidNumberMessage: null,
                    autofocus: true,
                    textAlignVertical: TextAlignVertical.center,
                    style: const TextStyle(fontSize: 25),
                    onChanged: (phone) => phoneNumber = phone.completeNumber,
                    initialCountryCode: 'KE',
                    flagsButtonPadding: const EdgeInsets.only(right: 10),
                    showDropdownIcon: false,
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              EasyContainer(
                color: Colors.blueGrey,
                child: const Text(
                  'Verify',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                width: double.infinity,
                onTap: () async {
                  if (isNullOrBlank(phoneNumber)) {
                    debugPrint(phoneNumber);
                    showSnackBar('Please enter a valid phone number!');
                  } else {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Confirm your phone number.'),
                        content: Text('Verify $phoneNumber ? '),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        VerifyPhoneNumber(phone: phoneNumber))),
                            child: const Text('Yes'),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
