import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:like_button/like_button.dart';

class ChatCourseCard extends StatelessWidget {
  final String courseName, imageUrl;
  const ChatCourseCard({Key key, this.courseName, this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          child: Card(
          elevation: 8.0,
          child: Column(
            children: <Widget>[
              Hero(
                tag: this.courseName,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: CachedNetworkImage(
                          colorBlendMode: BlendMode.hardLight,
                          imageUrl: imageUrl,
                          placeholder: (image, ctx) => Container(
                              width: 800,
                              child: AspectRatio(
                                aspectRatio: 1900 / 783,
                                child: BlurHash(
                                    hash: "L5H2EC=PM+yV0g-mq.wG9c010J}I"),
                              )),
                        ),
                        // child: Image.asset(
                        //     this.localImagePath),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 2.0),
                        child: Text(
                          this.courseName,
                          style: Theme.of(context).primaryTextTheme.headline,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    LikeButton(
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.favorite,
                          color: isLiked
                              ? Colors.red
                              : Theme.of(context).buttonColor,
                        );
                      },
                    )
                  ])
            ],
          )),
    );
  }
}
