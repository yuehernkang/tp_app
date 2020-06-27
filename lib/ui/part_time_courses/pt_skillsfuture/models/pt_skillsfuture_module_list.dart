import 'pt_skillsfuture_module.dart';

class PtSkillsFutureModuleList {
  final List<PtSkillsFutureModule> ptSkillsFutureModule;

  PtSkillsFutureModuleList({this.ptSkillsFutureModule});

  factory PtSkillsFutureModuleList.fromJson(List<dynamic> parsedJson) {
    List<PtSkillsFutureModule> ptSkillsFutureModule =
        new List<PtSkillsFutureModule>();
    ptSkillsFutureModule =
        parsedJson.map((i) => PtSkillsFutureModule.fromJson(i)).toList();

    return new PtSkillsFutureModuleList(
        ptSkillsFutureModule: ptSkillsFutureModule);
  }
}