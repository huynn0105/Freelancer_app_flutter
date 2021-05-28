import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/domain/services/http_service.dart';
import 'package:freelance_app/presentation/home/post_job/post_job_controller.dart';
import 'package:get/get.dart';
import 'job_name/job_name_screen.dart';

class PostJobScreen extends StatelessWidget {
  final controller = Get.put<PostJobController>(PostJobController(
    apiRepositoryInterface: Get.find(),
  ));


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Đăng việc'),
        ),
        body: Obx(
          ()=> controller.specialties.isNotEmpty ? Container(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Chọn lĩnh vực cần tuyển',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Container(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        final specialty = controller.specialties[index];
                        return ItemCategory(
                            image: specialty.image,
                            name: specialty.name,
                            tapEvent: () {
                              controller.specialtyId.value = specialty.id;
                              controller.getSpecialtyServices(specialty.id);
                              controller.specialtyTextController.text = specialty.name;
                              Get.to(() => JobNameScreen());
                            },
                          );
                      },
                      itemCount: controller.specialties.length,
                    ),
                  ),
                ),
              ],
            ),
          ) : const Center(
            child: CircularProgressIndicator(),
          ),
        ));
  }
}

class ItemCategory extends StatelessWidget {
  const ItemCategory({
    @required this.tapEvent,
    @required this.name,
    @required this.image,
    Key key,
  }) : super(key: key);
  final GestureTapCallback tapEvent;
  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tapEvent,
      child: Container(
        child: Card(
          color: Colors.green.shade300,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
              CachedNetworkImage(
                imageUrl: '$IMAGE/$image',
                httpHeaders: {HttpHeaders.authorizationHeader: 'Bearer $TOKEN'},
                placeholder: (context, url) => CupertinoActivityIndicator(),
                imageBuilder: (context, image) => Container(
                  child: Image(
                    image: image,
                    height: 110,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class PostJobOther extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         bottom: MyLinearProgressIndicator(
//           backgroundColor: Colors.white,
//           value: 0.3,
//         ),
//         title: Text(
//           'Other or not sure',
//           style: TextStyle(color: Colors.black),
//         ),
//         iconTheme: IconThemeData(
//           color: Colors.black, //change your color here
//         ),
//         backgroundColor: Colors.white,
//       ),
//       body: Container(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           children: [
//             Text(
//               'Should it be designed, built, or both?',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 22,
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Expanded(
//               child: Container(
//                 width: double.infinity,
//                 child: ListView.builder(
//                   itemBuilder: (context, index) {
//                     return Column(
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             Get.to(PostJobOther());
//                           },
//                           child: Row(
//                             children: [
//                               Text(
//                                 'Design and build it',
//                                 style: TextStyle(fontSize: 16),
//                               ),
//                               Spacer(),
//                               IconButton(
//                                   icon: Icon(Icons.keyboard_arrow_right),
//                                   onPressed: () {}),
//                             ],
//                           ),
//                         ),
//                         Divider(),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
