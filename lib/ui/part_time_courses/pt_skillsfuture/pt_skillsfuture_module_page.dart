import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import '../../app_bar/custom_app_bar.dart';
import 'models/pt_skillsfuture_module_list.dart';

class PtSkillsFutureModulesPage extends StatelessWidget {
  final PtSkillsFutureModuleList ptSkillsFutureModuleList;
  const PtSkillsFutureModulesPage({Key key, this.ptSkillsFutureModuleList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: CustomScrollView(
        slivers: [
        _StickyHeaderList(title: "Basic Modules", ptSkillsFutureModuleList: ptSkillsFutureModuleList),
        _StickyHeaderList(title: "Intermediate Modules",ptSkillsFutureModuleList: ptSkillsFutureModuleList),
        _StickyHeaderList(title: "Advanced Modules",ptSkillsFutureModuleList: ptSkillsFutureModuleList),
      ],
      ),
    );
  }
}

class _StickyHeaderList extends StatelessWidget {
  const _StickyHeaderList({
    Key key,
    this.title,
    this.ptSkillsFutureModuleList
  }) : super(key: key);

  final String title;
  final PtSkillsFutureModuleList ptSkillsFutureModuleList;

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: Header(title: this.title),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, i) => ListTile(
            title: Text(ptSkillsFutureModuleList.ptSkillsFutureModule[i].moduleName),
          ),
          childCount: ptSkillsFutureModuleList.ptSkillsFutureModule.length,
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key key,
    this.index,
    this.title,
    this.color = Colors.lightBlue,
  }) : super(key: key);

  final String title;
  final int index;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: color,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.centerLeft,
      child: Text(
        title ?? 'Header #$index',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}


