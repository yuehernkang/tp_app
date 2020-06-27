import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parallax_image/parallax_image.dart';
import 'package:tp_app/models/course.dart';

class FTCourseCard extends StatelessWidget {
  final Course course;
  const FTCourseCard({Key key, this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        children: <Widget>[
          Hero(
            tag: this.course.courseCode,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                child: Container(
                  padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      imageUrl: this.course.image,
                      placeholder: (image, ctx) => Container(
                          width: 800,
                          child: AspectRatio(
                            aspectRatio: 1900 / 783,
                            child:
                                BlurHash(hash: "L5H2EC=PM+yV0g-mq.wG9c010J}I"),
                          )),
                    ),
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
                  child: AutoSizeText(
                    this.course.courseName,
                    maxLines: 1,
                    style: Theme.of(context).primaryTextTheme.headline,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FTCourseCard2 extends StatelessWidget {
  final Course course;
  const FTCourseCard2({Key key, this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(
        children: <Widget>[
          Hero(
            tag: this.course.courseCode,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      imageUrl: this.course.image,
                      placeholder: (image, ctx) => Container(
                          width: 800,
                          child: AspectRatio(
                            aspectRatio: 1900 / 783,
                            child:
                                BlurHash(hash: "L5H2EC=PM+yV0g-mq.wG9c010J}I"),
                          )),
                    ),
                    // child: Image.asset(
                    //     this.localImagePath),
                  ),
                ),
              ),
            ),
          ),
          Text(
            this.course.courseName,
            style: TextStyle(fontSize: 28),
          )
        ],
      ),
    );
  }
}

class FTCourseCard3 extends StatelessWidget {
  final Course course;
  const FTCourseCard3({Key key, this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(
        children: <Widget>[
          Hero(
            tag: this.course.courseCode,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                child: Container(
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black, Colors.transparent],
                      ).createShader(
                          Rect.fromLTRB(0, 0, rect.width, rect.height));
                    },
                    blendMode: BlendMode.dstIn,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: CachedNetworkImage(
                        imageUrl: this.course.image,
                        errorWidget: (context, url, error) => Container(
                            child: AspectRatio(
                          aspectRatio: 1900 / 783,
                          child: BlurHash(hash: "L5H2EC=PM+yV0g-mq.wG9c010J}I"),
                        )),
                        placeholder: (image, ctx) => Container(
                            child: AspectRatio(
                          aspectRatio: 1900 / 783,
                          child: BlurHash(hash: "L5H2EC=PM+yV0g-mq.wG9c010J}I"),
                        )),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 140,
              ),
              Center(
                child: AutoSizeText(
                  this.course.courseName,
                  stepGranularity: 1,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.lato(
                      fontSize: 27,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).accentColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
