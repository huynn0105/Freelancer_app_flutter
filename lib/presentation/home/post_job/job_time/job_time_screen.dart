import 'package:flutter/material.dart';
import 'package:freelance_app/presentation/home/post_job/service_freelancer/service_freelancer_screen.dart';
import 'package:get/get.dart';

class JobTimeScreen extends StatefulWidget {
  @override
  _JobTimeScreenState createState() => _JobTimeScreenState();
}

class _JobTimeScreenState extends State<JobTimeScreen> {
  var today = DateTime.now();
  TextEditingController timeController = TextEditingController();
  @override
  void initState() {
    timeController.text = today.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Skills',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {
              Get.to(ServiceFreelancer());
            },
            child: Text(
              'Next',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Text(
              "Hạn cuối nhận chào giá của Freelancer",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: (){
                _selectDate(context);
              },
              child: TextField(
                controller: timeController,

                decoration: InputDecoration(
                  enabled: false,
                  prefixIcon: Icon(
                    Icons.calendar_today,
                    color: Colors.blue,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: today,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != today)
      setState(() {
        today = pickedDate;
      });
  }
}
