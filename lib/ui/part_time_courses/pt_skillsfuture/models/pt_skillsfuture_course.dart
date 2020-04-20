import 'pt_skillsfuture_module_list.dart';

class PtSkillsFutureCourse {
  String imageUrl, courseName, coverImageUrl, localImage;
  PtSkillsFutureModuleList basic = new PtSkillsFutureModuleList();
  PtSkillsFutureCourse(
      {this.courseName,
      this.imageUrl,
      this.coverImageUrl,
      this.localImage,
      this.basic});

  factory PtSkillsFutureCourse.fromJson(Map<String, dynamic> json) {
    return PtSkillsFutureCourse(
        courseName: json['courseName'] as String,
        imageUrl: json['imageUrl'] as String,
        localImage: json['localImage'] as String,
        coverImageUrl: json['coverImageUrl'] as String,
        basic: json['basic'] as PtSkillsFutureModuleList);
  }
}