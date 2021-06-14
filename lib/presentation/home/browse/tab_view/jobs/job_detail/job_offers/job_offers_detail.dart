import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';


class JobOffersDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nhận chào giá'),
      ),
      backgroundColor: Colors.grey[200],
      body: ListView.builder(itemBuilder: (_,index)=>ItemOffer(),itemCount: 10,),
    );
  }
}

class ItemOffer extends StatelessWidget {
  const ItemOffer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  foregroundColor: Colors.transparent,
                  backgroundColor: Colors.grey.shade300,
                  child: CachedNetworkImage(
                    imageUrl: 'https://thecastofcheers.com/images/9-best-online-avatars-and-how-to-make-your-own-[2020]-4.png',
                    placeholder: (context, url) =>
                        CupertinoActivityIndicator(),
                    imageBuilder: (context, image) => CircleAvatar(
                      backgroundImage: image,
                      radius: 27,
                    ),
                    errorWidget: (context, url, error) => CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage:
                      AssetImage('assets/images/avatarnull.png'),
                      radius: 27,
                    ),
                  ),
                ),
                SizedBox(
                  width: kDefaultPadding / 2,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Nguyễn Nhật Huy',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TEXT_STYLE_PRIMARY.copyWith(fontSize: 20),
                    ),
                    SmoothStarRating(
                      allowHalfRating: false,
                      onRated: (v) {},
                      starCount: 5,
                      rating: 5,
                      size: 18,
                      isReadOnly: true,
                      color: Colors.yellow,
                      borderColor: Colors.yellow,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 6),
            Row(
              children: [
                Icon(CupertinoIcons.money_dollar_circle),
                SizedBox(width: 6),
                Text('Chi phí đề xuất: 200.000 VNĐ',style: TEXT_STYLE_ON_FOREGROUND.copyWith(fontWeight: FontWeight.w500),),

              ],
            ),
            Row(
              children: [
                Icon(Icons.access_time_outlined),
                SizedBox(width: 6),
                Text('Dự kiến hoàn thành trong: 5 ngày',style: TEXT_STYLE_ON_FOREGROUND.copyWith(fontWeight: FontWeight.w500)),
              ],
            ),
            SizedBox(height: kDefaultPadding/2),
            Text('Nội dung chào giá',style: TEXT_STYLE_PRIMARY,),
            SizedBox(width: 4),
            ExpandableText('''Phần lớn là mình SỢ, sợ m.n sẽ không lời được từ việc đầu tư. Vì không ai chắc chắn ngày mai thị trường như thế nào, vì sao dự báo thời tiết lại gọi là  "dự báo", vì không thể chắc chắn ngày mai sẽ nắng nên gọi là dự báo. Nên không phải cứ xuống tiền là sẽ lời to, cái đó chỉ mấy ông đa cấp mới dám nói vậy.
              Khi đầu tư có cả nguyên nhân khách quan và chủ quan dẫn đến việc bạn bị thua lỗ.''',
              expandText: 'Xem thêm',
              collapseText: 'Ẩn đi',
              maxLines: 3,
            ),
            SizedBox(height: kDefaultPadding/2),
            Text('Kế hoạch thực hiện',style: TEXT_STYLE_PRIMARY,),
            SizedBox(width: 4),
            ExpandableText('''Phần lớn là mình SỢ, sợ m.n sẽ không lời được từ việc đầu tư. Vì không ai chắc chắn ngày mai thị trường như thế nào, vì sao dự báo thời tiết lại gọi là  "dự báo", vì không thể chắc chắn ngày mai sẽ nắng nên gọi là dự báo. Nên không phải cứ xuống tiền là sẽ lời to, cái đó chỉ mấy ông đa cấp mới dám nói vậy.
              Khi đầu tư có cả nguyên nhân khách quan và chủ quan dẫn đến việc bạn bị thua lỗ.''',
              expandText: 'Xem thêm',
              collapseText: 'Ẩn đi',
              maxLines: 3,
            ),
            ElevatedButton(onPressed: (){}, child: Text('Giao việc')),

          ],
        ),
      ),
    );
  }
}
