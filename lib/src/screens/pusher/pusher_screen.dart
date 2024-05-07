import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/screens/pusher/pusher_controller.dart';

class PusherScreen extends StatelessWidget {
  final PusherController pusherController = Get.put(PusherController());

  PusherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Obx(() => Text(pusherController.pusher.connectionState == 'DISCONNECTED'
              ? 'Pusher Channels Example'
              : pusherController.channelName.text)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => ListView(
              controller: pusherController.listViewController,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: <Widget>[
                if (pusherController.pusher.connectionState != 'CONNECTED')
                  Form(
                    key: pusherController.channelFormKey,
                    child: Column(
                      children: <Widget>[
                        // Resto del código...
                      ],
                    ),
                  )
                else
                  Form(
                    key: pusherController.eventFormKey,
                    child: Column(
                      children: <Widget>[
                        // Resto del código...
                      ],
                    ),
                  ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Obx(() => Text(pusherController.log.value)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}