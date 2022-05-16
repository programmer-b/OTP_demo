part of 'package:validus_otp_demo/app.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({Key? key, required this.icon, required this.text, this.onTap}) : super(key: key);

  final IconData icon;
  final String text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 10,
        child: Container(
          width: 150,
          height: 83,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Icon(icon, color: Colors.black54, size: 35,),
              const SizedBox(height: 9,),
              Text(text, style: const TextStyle(fontSize: 16),),

            ],
          ),
        ),
      ),
    );
  }
}
