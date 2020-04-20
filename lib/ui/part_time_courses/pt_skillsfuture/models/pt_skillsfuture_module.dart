class PtSkillsFutureModule {
  String moduleName, moduleInfo, who, entryRequirement;
  PtSkillsFutureModule(
      {this.moduleName, this.moduleInfo, this.who, this.entryRequirement});

  factory PtSkillsFutureModule.fromJson(Map<String, dynamic> json) {
    return PtSkillsFutureModule(
      moduleName: json['moduleName'] as String,
      moduleInfo: json['moduleInfo'] as String,
      who: json['who'] as String,
      entryRequirement: json['entryRequirement'] as String,
    );
  }
}