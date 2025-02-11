import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:vtschool/src/config/theme/app_theme.dart';
import 'package:vtschool/src/screens/recover_password/recover_password_controller.dart';

class RecoverPasswordOtpScreen extends StatelessWidget {
  final RecoverPasswordController _recoverPasswordController =
      Get.put(RecoverPasswordController());
  RecoverPasswordOtpScreen({super.key});

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
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  width: 370,
                  height: 340,
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
                      // Título
                      Text(
                        'VERIFICACIÓN',
                        style: TextStyle(
                          color: listColor[15],
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),

            
                      const Text(
                        'Escriba el codigo de verificacion que le hemos enviado a su correo',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      PinCodeTextField(
                        appContext: context,
                        length: 6,
                        controller: _recoverPasswordController.otpController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {},
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeColor: listColor[15],
                          selectedColor: listColor[16],
                          inactiveColor: Colors.grey,
                        ),
                      ),
                    
                      TextButton(
                        onPressed: () async{
                          Get.offAllNamed('/login');
                          await _recoverPasswordController.clearAllPreferences();

                        },
                        child: Text(
                          "¿No resiviste el codigo? Reenviar",
                          style: TextStyle(color: listColor[15]),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Obx((){
                        return _recoverPasswordController.sendOtpIsLoading.value ?
                        const Center(
                          child: CircularProgressIndicator(),
                        ) :  ElevatedButton(
                        onPressed: () {
                          _recoverPasswordController.validateOtp();
                          FocusScope.of(context).requestFocus();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: listColor[15],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        child: const Text(
                          'ENVIAR CÓDIGO',
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
