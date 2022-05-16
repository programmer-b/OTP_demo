part of 'package:validus_otp_demo/app.dart';

class VerifyPhoneNumber extends StatefulWidget {
  static const id = 'VerifyPhoneNumberScreen';
  const VerifyPhoneNumber({Key? key, required this.phone}) : super(key: key);
  final String phone;

  @override
  State<VerifyPhoneNumber> createState() => _VerifyPhoneNumberState();
}

class _VerifyPhoneNumberState extends State<VerifyPhoneNumber>
    with WidgetsBindingObserver {
  bool isKeyboardVisible = false;

  late final ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomViewInsets = WidgetsBinding.instance!.window.viewInsets.bottom;
    isKeyboardVisible = bottomViewInsets > 0;
  }

  // scroll to bottom of screen, when pin input field is in focus.
  Future<void> _scrollToBottomOnKeyboardOpen() async {
    while (!isKeyboardVisible) {
      await Future.delayed(const Duration(milliseconds: 50));
    }

    await Future.delayed(const Duration(milliseconds: 250));

    await scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeIn,
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: FirebasePhoneAuthProvider(
            child: FirebasePhoneAuthHandler(
      phoneNumber: widget.phone,
      onLoginSuccess: (userCredential, autoVerified) async {
        showSnackBar('Phone number verified successfully!');

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HomeScreen(userId: userCredential.user?.uid)));
      },
      onLoginFailed: (authException) {
        _showSnackBar('Something went wrong!');

        // handle error further if needed
      },
      builder: (context, controller) {
        return Scaffold(
          backgroundColor: Colors.white54,
          appBar: AppBar(
            title: const Text('Verify'),
            actions: [
              if (controller.codeSent)
                TextButton(
                  child: Text(
                    controller.timerIsActive
                        ? '${controller.timerCount.inSeconds}s'
                        : 'Resend',
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  onPressed: controller.timerIsActive
                      ? null
                      : () async {
                          log(VerifyPhoneNumber.id, msg: 'Resend OTP');
                          await controller.sendOTP();
                        },
                ),
              const SizedBox(width: 5),
            ],
          ),
          body: controller.codeSent
              ? ListView(
                  padding: const EdgeInsets.all(20),
                  controller: scrollController,
                  children: [
                    Text(
                      "We've sent an SMS with a verification code to ${widget.phone}",
                      style: const TextStyle(fontSize: 25),
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                    if (controller.timerIsActive)
                      Column(
                        children: const [
                          CircularProgressIndicator(),
                          SizedBox(height: 50),
                          Text(
                            'Listening for OTP',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 15),
                          Divider(),
                          Text('OR', textAlign: TextAlign.center),
                          Divider(),
                        ],
                      ),
                    const SizedBox(height: 15),
                    const Text(
                      'Enter OTP',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 15),
                    PinInputField(
                      length: 6,
                      onFocusChange: (hasFocus) async {
                        if (hasFocus) await _scrollToBottomOnKeyboardOpen();
                      },
                      onSubmit: (enteredOTP) async {
                        final isValidOTP = await controller.verifyOTP(
                          otp: enteredOTP,
                        );
                        // Incorrect OTP
                        if (!isValidOTP) {
                          showSnackBar('The entered OTP is invalid!');
                        }
                      },
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(height: 50),
                    Center(
                      child: Text(
                        'Sending OTP',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ],
                ),
        );
      },
    )));
  }
}
