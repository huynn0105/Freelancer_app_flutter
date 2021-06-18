import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/presentation/home/browse/tab_view/freelancers/rating/rating_screen.dart';
import 'package:get/get.dart';
class ChatDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: ListView(

          children: [
            Text('Thành viên',style: TEXT_STYLE_PRIMARY,),
            SizedBox(height: kDefaultPadding/4),
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  foregroundColor: Colors.transparent,
                  backgroundColor: Colors.grey.shade300,
                  child: CachedNetworkImage(
                    imageUrl:
                    'https://thecastofcheers.com/images/9-best-online-avatars-and-how-to-make-your-own-[2020]-4.png',
                    placeholder: (context, url) => CupertinoActivityIndicator(),
                    imageBuilder: (context, image) => CircleAvatar(
                      backgroundImage: image,
                      radius: 22,
                    ),
                    errorWidget: (context, url, error) => CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage:
                      AssetImage('assets/images/avatarnull.png'),
                      radius: 22,
                    ),
                  ),
                ),
                SizedBox(
                  width: kDefaultPadding / 2,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      'Nguyễn Nhật Huy',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(color: Colors.blue,fontSize: 16,fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 3),
                    Opacity(
                      opacity: 0.64,
                      child: Text('Hoạt động 5 giờ trước',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 13),
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: kDefaultPadding/4),
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  foregroundColor: Colors.transparent,
                  backgroundColor: Colors.grey.shade300,
                  child: CachedNetworkImage(
                    imageUrl:
                    'https://thecastofcheers.com/images/9-best-online-avatars-and-how-to-make-your-own-[2020]-4.png',
                    placeholder: (context, url) => CupertinoActivityIndicator(),
                    imageBuilder: (context, image) => CircleAvatar(
                      backgroundImage: image,
                      radius: 22,
                    ),
                    errorWidget: (context, url, error) => CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage:
                      AssetImage('assets/images/avatarnull.png'),
                      radius: 22,
                    ),
                  ),
                ),
                SizedBox(
                  width: kDefaultPadding / 2,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      'Nguyễn Nhật Huy',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(color: Colors.blue,fontSize: 16,fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 3),
                    Opacity(
                      opacity: 0.64,
                      child: Text('Hoạt động 5 giờ trước',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 13),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Divider(),
            SizedBox(height: kDefaultPadding/2),
            Text('Tuỳ chọn',style: TEXT_STYLE_PRIMARY),
            SizedBox(height: kDefaultPadding/4),
            ListTile(onTap: (){
              Get.to(()=>RatingScreen());
            },leading: Icon(Icons.check,color: Colors.green,),title: Text('Hoàn thành công việc',style: TextStyle(fontSize: 18),),),
            ListTile(onTap: (){},leading:Icon(Icons.refresh_outlined,color: Colors.blue,),title: Text('Yêu cầu làm lại',style: TextStyle(fontSize: 18)),),
            ListTile(onTap: (){},leading: Icon(Icons.cancel_outlined,color: Colors.red,),title: Text('Huỷ công việc',style: TextStyle(fontSize: 18)),),
          ],
        ),
      ),
    );
  }
}
