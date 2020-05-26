import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:tp_app/home_page/models/highlight_object.dart';
import 'package:url_launcher/url_launcher.dart';

class HighlightsSlideshow extends StatelessWidget {
  const HighlightsSlideshow({
    Key key,
    @required this.imageUrlList,
  }) : super(key: key);

  final List<HighlightObject> imageUrlList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Swiper(
        itemCount: imageUrlList.length,
        autoplay: true,
        loop: true,
        duration: 1500,
        pagination: new SwiperPagination(),
        itemBuilder: (BuildContext context, int index) {
          return new InkWell(
            onTap: (){
              launch(imageUrlList[index].targetUrl);
            },
            child: Image.network(
              imageUrlList[index].highlightImageUrl,
              fit: BoxFit.fill,
            ),
          );
        },
      ),
    );
  }
}
