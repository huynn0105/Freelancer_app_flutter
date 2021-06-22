import 'package:flutter/material.dart';
import 'package:freelance_app/presentation/routes/navigation.dart';
import 'package:get/get.dart';
class JobFinished extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/images/success.gif'),height: 150,),
            Padding(
              padding: const EdgeInsets.only(top: 10,bottom: 30),
              child: Text('Dự án đã hoàn thành!',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 20,),

            ElevatedButton(
              onPressed: () {

                Get.offAllNamed(Routes.home);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text(
                'Trang chủ',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
