part of 'package:validus_otp_demo/app.dart';

enum Menu { itemOne, itemTwo, itemThree, itemFour }

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _showSnackBar(String message) {
    Future.delayed(Duration.zero, () {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello there, John"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          PopupMenuButton<Menu>(
              // Callback that sets the selected popup menu item.
              onSelected: (value) {
                switch (value) {
                  case Menu.itemOne:
                    break;
                  case Menu.itemTwo:
                    break;
                  case Menu.itemThree:
                    break;
                  case Menu.itemFour:
                    break;
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                    const PopupMenuItem<Menu>(
                      value: Menu.itemOne,
                      child: Text('Item 1'),
                    ),
                    const PopupMenuItem<Menu>(
                      value: Menu.itemTwo,
                      child: Text('Item 2'),
                    ),
                    const PopupMenuItem<Menu>(
                      value: Menu.itemThree,
                      child: Text('Item 3'),
                    ),
                    const PopupMenuItem<Menu>(
                      value: Menu.itemFour,
                      child: Text('Item 4'),
                    ),
                  ])
        ],
      ),
      drawer: const ComplexDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            _row(
                const HomeButton(
                    icon: FontAwesomeIcons.servicestack, text: 'View services'),
                const HomeButton(
                    icon: FontAwesomeIcons.calendarCheck,
                    text: 'Check for updates')),
            _row(
                const HomeButton(
                    icon: FontAwesomeIcons.codePullRequest,
                    text: 'Request services'),
                const HomeButton(
                    icon: FontAwesomeIcons.bugSlash, text: 'Report an issue')),
            _row(
                const HomeButton(
                    icon: FontAwesomeIcons.filePen, text: 'Update status'),
                const HomeButton(
                    icon: FontAwesomeIcons.user, text: 'Update profile')),
          ],
        ),
      ),
    );
  }
}

Widget _row(Widget right, Widget left) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [right, left],
      ),
      const SizedBox(
        height: 15,
      )
    ],
  );
}

class ComplexDrawer extends StatelessWidget {
  const ComplexDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
