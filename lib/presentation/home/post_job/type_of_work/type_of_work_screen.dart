import 'package:flutter/material.dart';
import 'package:freelance_app/presentation/home/post_job/form_of_work/form_of_work_screen.dart';
import 'package:freelance_app/presentation/home/post_job/post_job_controller.dart';

import 'package:get/get.dart';

class TypeOfWorkScreen extends StatelessWidget {
  final controller = Get.find<PostJobController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Thông tin đầy đủ về yêu cầu tuyển dụng',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Obx(
        ()=> controller.typeOfWorks.isNotEmpty ? Container(
          padding: EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Loại hình công việc',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 25,
              ),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var typeOfWork = controller.typeOfWorks[index];
                  return ItemWork(
                      title: typeOfWork.name,
                      onTap: () {
                        controller.typeId.value = typeOfWork.id;
                        Get.to(() => FormOfWorkScreen());
                      });
                },
                itemCount: controller.typeOfWorks.length,
              ),
            ],
          ),
        ) : const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class ItemWork extends StatelessWidget {
  const ItemWork({
    @required this.title,
    @required this.onTap,
    Key key,
  }) : super(key: key);
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.grey[400],width: 2.4)
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue
                  ),
                ),
                Spacer(),
                Icon(Icons.keyboard_arrow_right,color: Colors.blue,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
