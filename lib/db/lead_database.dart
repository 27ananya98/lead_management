import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import '../model/lead.dart';
import 'lead_dao.dart';

part 'lead_database.g.dart';




@Database(version: 1, entities: [Lead])
abstract class LeadDatabase extends FloorDatabase {
  LeadDao get leadDao;
}