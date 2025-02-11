import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/config/theme/app_theme.dart';
import 'package:path/path.dart' as path;
import 'package:vtschool/src/screens/support/support_controller.dart';

class SupportScreen extends StatelessWidget {
  final SupportController _supportController = Get.put(SupportController());
  SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/support.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.all(15.0),
                width: 370,
                height: 360,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: Colors.white,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'SOPORTE TÉCNICO',
                      style: TextStyle(
                        color: listColor[15],
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Flexible(
                      child: Container(
                        color: Colors.transparent,
                        child: TextField(
                          onChanged: (value) {},
                          controller: _supportController.comment,
                          maxLines: null,
                          keyboardType: TextInputType.text,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            hintText: "DESCRIPCIÓN",
                            labelText: 'DESCRIPCIÓN',
                            hintStyle: TextStyle(color: listColor[15]),
                            labelStyle: TextStyle(
                                color: listColor[15],
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            prefixIcon: Icon(
                              Icons.textsms_outlined,
                              color: listColor[15],
                            ),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: listColor[15], width: 5),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: listColor[15], width: 1),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: listColor[15], width: 1.5),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 7.0, horizontal: 20),
                          ),
                          style: TextStyle(
                            color: listColor[15],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8.0),
                          const Padding(
                            padding: EdgeInsets.only(left: 18.0),
                            child: Text('ARCHIVO (OPCIONAL)'),
                          ),
                          const SizedBox(
                            height: 3.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  FilePickerResult? result =
                                      await FilePicker.platform.pickFiles();
                                  if (result != null) {
                                    File file = File(result.files.single.path!);
                                    String filePath = result.files.single.path!;
                                    _supportController
                                        .setSelectedFilePath(filePath);
                                    _supportController.setFilePath(file);
                                  }
                                },
                                child: const Text('SELECCIONAR ARCHIVO'),
                              ),
                              const SizedBox(width: 5),
                              Obx(() {
                                if (_supportController
                                    .selectedFilePath.value.isNotEmpty) {
                                  String fileName = path.basename(
                                      _supportController
                                          .selectedFilePath.value);
                                  return Flexible(
                                    child: ElevatedButton(
                                      onPressed: null,
                                      child: Text(fileName),
                                    ),
                                  );
                                } else {
                                  return const ElevatedButton(
                                    onPressed: null,
                                    child: Text('ARCHIVO'),
                                  );
                                }
                              }),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Obx(() {
                      return _supportController.sendSupportValue.value
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                              onPressed: () async {
                                FocusScope.of(context).requestFocus();
                                await _supportController.sendSupport();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: listColor[15],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                              child: const Text(
                                'ENVIAR',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            );
                    }),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
