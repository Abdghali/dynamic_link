import 'package:flutter/material.dart';

import 'dynamic_link_services.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    DynamicLinkServices.instance.retrieveDynamicLink(context);
    super.initState();
  }

  TextEditingController _controller = TextEditingController();
  String link = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFormField(
          controller: _controller,
        ),
        ElevatedButton(
          onPressed: (() async {
            // link = await DynamicLinkServices.instance
            //     .createDynamicLink(_controller.text);
            String image =
                'https://firebasestorage.googleapis.com/v0/b/dynamic-link-app-df5f8.appspot.com/o/image1.jpeg?alt=media&token=56147a27-d102-4e90-8162-76158774ce5b';
            await DynamicLinkServices.instance
                .buildDynamicLink("post one", image, "123456",'invite',context: context);
            setState(() {});
          }),
          child: Text('Go to post'),
        ),
        Text(link)
      ],
    )));
  }
}
