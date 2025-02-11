import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/config/theme/app_theme.dart';
import 'package:vtschool/src/screens/update_password/update_password_controller.dart';

class UpdatePasswordScreen extends StatelessWidget {
  final UpdatePasswordController _updatePasswordController =
      Get.put(UpdatePasswordController());
  UpdatePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/otp.jpg'),
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
                        'ACTUALIZAR CONTRASEÑA',
                        style: TextStyle(
                          color: listColor[15],
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        color: Colors.transparent,
                        child: Obx(
                          () => TextField(
                            obscureText: !_updatePasswordController
                                .isCurrentPasswordVisible.value,
                            onChanged: (value) {},
                            controller: _updatePasswordController
                                .currentPasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.transparent,
                              hintText: "CONTRASEÑA ACTUAL",
                              labelText: 'CONTRASEÑA ACTUAL',
                              hintStyle: TextStyle(color: listColor[15]),
                              labelStyle: TextStyle(
                                  color: listColor[15],
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                              prefixIcon: Icon(
                                Icons.password,
                                color: listColor[15],
                              ),
                              suffixIcon: IconButton(
                                  icon: Icon(_updatePasswordController
                                          .isCurrentPasswordVisible.value
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: _updatePasswordController
                                      .toggleCurrentPasswordVisibility,
                                  color: _updatePasswordController
                                          .isCurrentPasswordVisible.value
                                      ? listColor[16]
                                      : listColor[15]),
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
                                borderSide: BorderSide(
                                    color: listColor[15], width: 1.5),
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
                        color: Colors.transparent,
                        child: Obx(
                          () => TextField(
                            obscureText: !_updatePasswordController
                                .isNewPasswordVisible.value,
                            onChanged: (value) {},
                            controller:
                                _updatePasswordController.newPasswordController,
                            keyboardType: TextInputType.emailAddress,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.transparent,
                              hintText: "NUEVA CONTRASEÑA",
                              labelText: 'NUEVA CONTRASEÑA',
                              hintStyle: TextStyle(color: listColor[15]),
                              labelStyle: TextStyle(
                                  color: listColor[15],
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                              prefixIcon: Icon(
                                Icons.password,
                                color: listColor[15],
                              ),
                              suffixIcon: IconButton(
                                  icon: Icon(_updatePasswordController
                                          .isNewPasswordVisible.value
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: _updatePasswordController
                                      .toggleNewPasswordVisibility,
                                  color: _updatePasswordController
                                          .isNewPasswordVisible.value
                                      ? listColor[16]
                                      : listColor[15]),
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
                                borderSide: BorderSide(
                                    color: listColor[15], width: 1.5),
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
                        color: Colors.transparent,
                        child: Obx(
                          () => TextField(
                            obscureText: !_updatePasswordController
                                .isRecoverPasswordVisible.value,
                            onChanged: (value) {},
                            controller: _updatePasswordController
                                .recoverPasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.transparent,
                              hintText: "CONFIRMAR CONTRASEÑA",
                              labelText: 'CONFIRMAR CONTRASEÑA',
                              hintStyle: TextStyle(color: listColor[15]),
                              labelStyle: TextStyle(
                                  color: listColor[15],
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                              prefixIcon: Icon(
                                Icons.password,
                                color: listColor[15],
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(_updatePasswordController
                                        .isRecoverPasswordVisible.value
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: _updatePasswordController
                                    .toggleRecoverPasswordVisibility,
                                color: _updatePasswordController
                                        .isRecoverPasswordVisible.value
                                    ? listColor[16]
                                    : listColor[15],
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
                                borderSide: BorderSide(
                                    color: listColor[15], width: 1.5),
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
                      Obx((){
                        return _updatePasswordController.sendPassword.value ? 
                        const Center(
                          child: CircularProgressIndicator()
                        ) : ElevatedButton(
                        onPressed: () async {
                          FocusScope.of(context).requestFocus();
                          await _updatePasswordController.changePassword();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: listColor[15],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        child: const Text(
                          'CAMBIAR CONTRASEÑA',
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
      ),
    );
  }
}
